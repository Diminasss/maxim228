from flask import Flask, request, jsonify, wrappers
from config import *
from CourseBaseFunk import *
from UserBaseFunk import *


app = Flask(__name__)

user_initialisation("1", "1", "Дима", "Никитин", "Михайлович", "2004-10-21", "ГУАП", False, ['13 dima , please', '213'], ['2'])
edit_sqlite_table("users", "example@mail.com", "first_name", "Максим")
print(get_from_postgresql_table("users", "example@mail.com", "current_courses"))
print(user_is_in_table("example@mail.com"))
get_all_information_from_user_exclude_password("example@mail.com")

course_initialisation("Зарубежная", "Таганков", ["example@mail.com", "maksim@levchenko.ru"], ["Уайлд", "Наполеон", "Кристи"], ["Тест 1"])


# Добавляем обработчик для CORS
@app.after_request
def after_request(response) -> wrappers.Response:
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
    response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
    return response


@app.route("/")
def main_page():
    return "Main Page"


@app.route("/person", methods=['POST'])
def get_person() -> tuple[wrappers.Response, int]:
    # Получаем данные из тела запроса в формате JSON
    request_data = request.get_json()

    # Извлекаем значение титла из полученных данных
    login: str = request_data.get('login')
    person_info = get_all_information_from_user_exclude_password(login)
    if person_info is not None:
        return jsonify(person_info), 200
    else:
        return jsonify({"response": "dontwork"}), 201


@app.route('/auth', methods=['POST'])
def auth() -> tuple[wrappers.Response, int]:
    # Получаем данные из тела запроса в формате JSON
    request_data = request.get_json()
    # Извлекаем значение титла из полученных данных
    login: str = request_data.get('login')
    password_from_user: str = request_data.get('password')
    if user_is_in_table(login):
        password = get_from_postgresql_table("users", login, "password")
        if password_from_user == password:
            return jsonify({'response': True}), 200
        else:
            return jsonify({'response': False}), 200
    else:
        return jsonify({'response': False}), 200


@app.route('/course', methods=['POST'])
def about() -> tuple[wrappers.Response, int]:
    request_data = request.get_json()
    course_id = request_data.get('course_id')
    course_info: dict = get_all_information_from_course(course_id)
    if course_info is not None:
        return jsonify(course_info), 200
    else:
        return jsonify({"response": "dontwork"}), 201


if __name__ == '__main__':
    app.run(debug=True)
