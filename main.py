from flask import Flask, request, jsonify
from config import *
import psycopg2

app = Flask(__name__)

# Инициализация БД
try:
    connection = psycopg2.connect(user="postgres", password="qwerty", host="127.0.0.1", port="5432", database="postgres")
    connection.autocommit = True
    cursor = connection.cursor()

    cursor.execute("""CREATE TABLE IF NOT EXISTS users(
    login varchar(100) PRIMARY KEY,
    password varchar(20) NOT NULL,
    last_name varchar(100) NOT NULL,
    first_name varchar(100) NOT NULL,
    patronymic varchar(100) NOT NULL,
    date_of_birth date NOT NULL,
    department varchar(100) NOT NULL,
    current_courses VARCHAR(255) ARRAY,
    completed_courses VARCHAR(255) ARRAY)""")

    print("Успешное создание/подключение к таблице")
except psycopg2.OperationalError as e:
    print("Ошибка при подключении к базе данных:", e)


# Метод по инициализации пользователя
def initialisation(login: str, password: str, last_name: str, first_name: str, patronymic: str, date_of_birth: str, department: str, current_courses: list, completed_courses: list) -> None:
    try:
        cursor.execute("""INSERT INTO users (login, password, last_name, first_name, patronymic, date_of_birth, department, current_courses, completed_courses) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)""", (login, password, first_name, last_name, patronymic, date_of_birth, department, current_courses, completed_courses))
        print("Успешная ")
    except psycopg2.IntegrityError as e:
        print("Ошибка при инициализации:", e)


initialisation("example@mail.com", "pass228339", "Дима", "Никитин", "Михайлович", "2004-10-21", "ГУАП", [], [])


def edit_sqlite_table(login: str, what_to_edit: str, value: str | list | int) -> None:
    """
    Поля для редактирования на выбор\n
    login\n
    password\n
    first_name\n
    last_name\n
    patronymic\n
    date_of_birth\n
    department\n
    current_courses\n
    completed_courses
    :param login:
    :param what_to_edit:
    :param value:
    :return:
    """
    try:
        cursor.execute(f"""UPDATE users SET {what_to_edit} = %s WHERE login = %s""", (value, login))
    except psycopg2.IntegrityError as e:
        print("Ошибка при редактировании:", e)


edit_sqlite_table('example@mail.com', 'last_name', 'Жуков')

# Добавляем обработчик для CORS
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
    response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
    print(type(response))
    return response


@app.route("/")
def main_page():
    return "Main Page"


@app.route('/auth', methods=['POST'])
def auth():
    # Получаем данные из тела запроса в формате JSON
    request_data = request.get_json()

    # Извлекаем значение титла из полученных данных
    title = request_data.get('login')
    print(request_data)

    # Выводим значение титла на экран
    print("Title:", title)

    # Отправляем ответ об успешном выполнении
    return jsonify({'message': 'Засунь в попку))))'}), 200


@app.route('/about', methods=['POST'])
def about():
    # Получаем данные из тела запроса в формате JSON
    request_data = request.get_json()

    # Извлекаем значение титла из полученных данных
    title = request_data.get('title')
    print(request_data)

    # Выводим значение титла на экран
    print("Title:", title)

    # Отправляем ответ об успешном выполнении
    return jsonify({'message': 'Засунь в попку))))'}), 200


if __name__ == '__main__':
    app.run(debug=True)
