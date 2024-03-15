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
    login serial PRIMARY KEY,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    patronymic varchar(100) NOT NULL,
    date_of_birth date NOT NULL,
    department varchar(100) NOT NULL,
    current_courses VARCHAR(255) [],
    completed_courses VARCHAR(255) [])""")

    print("Успешное создание/подключение к таблице")
except psycopg2.OperationalError as e:
    print("Ошибка при подключении к базе данных:", e)


# Метод по инициализации пользователя
def initialisation(login: str, first_name: str, last_name: str, patronymic: str, date_of_birth: str, department: str, current_courses: list, completed_courses: list) -> None:
    try:
        cursor.execute("""INSERT INTO users (login, first_name, last_name, patronymic, date_of_birth, department, current_courses, completed_courses) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""", (login, first_name, last_name, patronymic, date_of_birth, department, current_courses, completed_courses))

    except psycopg2.IntegrityError as e:
        print("Ошибка при подключении к базе данных:", e)


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
    pass


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
