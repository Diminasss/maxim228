from DataBaseFunk import cursor
from psycopg2 import IntegrityError, OperationalError


def test_initialisation(test_id: int, test_name: str, test_text: str, input_data: str, output_data: str) -> None | int:
    try:
        cursor.execute("""SELECT EXISTS (SELECT 1 FROM tests);""")
    except OperationalError as e:
        print("Ошибка доступа к базе в инициализации", e)
    table_is_empty: bool = not (cursor.fetchone()[0])
    if table_is_empty:
        course_id = 1
    else:
        cursor.execute("""SELECT MAX(test_id) FROM tests;""")
        course_id = cursor.fetchone()[0] + 1
    try:
        cursor.execute(
            """INSERT INTO tests (test_id, test_name, test_text, input_data, output_data) VALUES (%s, %s, %s, %s, %s)""",
            (test_id, test_name, test_text, input_data, output_data))
    except IntegrityError as e:
        print(e)
