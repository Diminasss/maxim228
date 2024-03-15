from flask import Flask, request, jsonify
from config import *
from DataBaseFunk import database_connection, edit_sqlite_table, initialisation


app = Flask(__name__)

initialisation("example@mail.com", "pass228339", "Дима", "Никитин", "Михайлович", "2004-10-21", "ГУАП", False, [], [])
edit_sqlite_table("users", "example@mail.com", "first_name", "Максим")


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
