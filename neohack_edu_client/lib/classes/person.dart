class Person {
  String? login;
  String? password;
  String? lastName;
  String? firstName;
  String? patronymic;
  String? dateOfBirth;
  String? department;
  bool? isTeacher;
  List<String>? currentCourses;
  List<String>? completedCourses;

  Person(
      {this.login,
      this.password,
      this.lastName,
      this.firstName,
      this.patronymic,
      this.dateOfBirth,
      this.department,
      this.isTeacher,
      this.currentCourses,
      this.completedCourses});

  Person.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    patronymic = json['patronymic'];
    dateOfBirth = json['date_of_birth'];
    department = json['department'];
    isTeacher = json['is_teacher'];
    currentCourses = json['current_courses'].cast<String>();
    completedCourses = json['completed_courses'].cast<String>();
  }
}
