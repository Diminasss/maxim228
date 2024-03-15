import 'dart:convert';
import 'dart:developer';

class Person {
  String? login;
  String? password;
  String? lastName;
  String? firstName;
  String? patronymic;
  String? dateOfBirth;
  String? department;
  bool? isTeacher;
  List<int>? currentCourses;
  List<int>? completedCourses;

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
    currentCourses = [];
    completedCourses = [];
    List<dynamic> curr = List.from(json['current_courses']);
    for (var element in curr) {
      log('$element curr');
      currentCourses!.add(int.parse(element));
    }
    List<dynamic> comp = List.from(json['completed_courses']);
    for (var element in comp) {
      log(element);
      completedCourses!.add(int.parse(element));
    }
  }
}
