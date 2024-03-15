from DataBaseFunk import cursor
from psycopg2 import IntegrityError, OperationalError


def course_initialisation(course_name: str, author: str, access_group: list, lectures_inside_course: list, tests_inside_course: list) -> None:
    try:
        cursor.execute("""SELECT EXISTS (SELECT 1 FROM course);""")
    except OperationalError as e:
        print("Ошибка доступа к базе в инициализации")
    table_is_empty: bool = not(cursor.fetchone()[0])
    if table_is_empty:
        course_id = 1
    else:
        cursor.execute("""SELECT MAX(course_id) FROM course;""")
        course_id = cursor.fetchone()[0] + 1
    try:
        cursor.execute(
            """INSERT INTO course (course_id, course_name, author, access_group, lectures_inside_course, tests_inside_course) VALUES (%s, %s, %s, %s, %s, %s)""",
            (course_id, course_name, author, access_group, lectures_inside_course, tests_inside_course))
    except IntegrityError as e:
        print(e)
