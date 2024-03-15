import psycopg2
from config import username, password, host, port, database_name


# Инициализация БД
def database_connection() -> psycopg2.connect:
    try:
        connection = psycopg2.connect(user=username, password=password, host=host, port=port,
                                      database=database_name)
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
        is_teacher boolean NOT NULL,
        current_courses VARCHAR(255) ARRAY,
        completed_courses VARCHAR(255) ARRAY)""")

        print("Успешное создание/подключение к таблице")
        return cursor
    except psycopg2.OperationalError as e:
        print("Ошибка при подключении к базе данных:", e)


cursor = database_connection()


def user_is_in_table(login: str) -> bool | None:
    """
    Есть ли пользователь в таблице?
    :param login:
    :return:
    """
    try:
        cursor.execute(f"""SELECT EXISTS(SELECT 1 FROM users WHERE login = %s)""", (login,))
        all_users = cursor.fetchall()
        is_in_column = all_users[0][0]
        return is_in_column
    except psycopg2.OperationalError as e:
        print(f"ошибка обнаружения {e}")
        user_is_in_table(login)


# Метод по инициализации пользователя
def initialisation(login: str, password: str, last_name: str, first_name: str, patronymic: str, date_of_birth: str, department: str, is_teacher: bool, current_courses: list, completed_courses: list) -> None:
    if user_is_in_table(login):
        pass
    else:
        try:
            cursor.execute("""INSERT INTO users (login, password, last_name, first_name, patronymic, date_of_birth, department, is_teacher, current_courses, completed_courses) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""", (login, password, first_name, last_name, patronymic, date_of_birth, department, is_teacher, current_courses, completed_courses))
            print("Успешная ")
        except psycopg2.IntegrityError as e:
            print("Ошибка при инициализации:", e)


def edit_sqlite_table(table_name: str, login: str, what_to_edit: str, value: str | list | int) -> None:
    """
    Таблицы на выбор:\n
    users\n\n
    Поля на выбор:\n
    login\n
    password\n
    first_name\n
    last_name\n
    patronymic\n
    date_of_birth\n
    department\n
    current_courses\n
    completed_courses\n
    :param table_name:
    :param login:
    :param what_to_edit:
    :param value:
    :return:
    """
    if user_is_in_table(login):
        try:
            cursor.execute(f"""UPDATE {table_name} SET {what_to_edit} = %s WHERE login = %s""", (value, login))
        except psycopg2.IntegrityError as e:
            print("Ошибка при редактировании:", e)
    else:
        print("Нет записи по логину")


def get_from_postgresql_table(table_name: str, login: str, what_to_get: str) -> str | list | int | bool | None:
    """Функция возвращает None, если не находит данные"""
    if user_is_in_table(login):
        try:
            cursor.execute(f"""SELECT {what_to_get} FROM {table_name} WHERE login = %s""", (login,))
            value = cursor.fetchone()[0]
            return value if value is not None else None
        except psycopg2.IntegrityError as e:
            print("Ошибка получения данных при подключении:", e)
            return None
    else:
        return None
