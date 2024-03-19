import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neohack_edu_client/classes/person.dart';

class TeachCoursesPage extends StatelessWidget {
  TeachCoursesPage({Key? key, this.person});

  Person? person;

  Future<List<Map<String, dynamic>>> getCoursesName() async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/course'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'login': person!.login,
        'course_id': List.from(person!.currentCourses!)
          ..addAll(person!.completedCourses!),
      }),
    );

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)['courses']);
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  Widget _tileBuilder(
      List<Map<dynamic, dynamic>> courses, int currSize, BuildContext context) {
    List<Widget> courseRows = [const SizedBox(width: 40)];
    for (int i = 0; i < courses.length; i += 3) {
      List<Widget> rowCourses = [];
      rowCourses.add(const SizedBox(width: 40));
      for (int j = i; j < i + 3 && j < courses.length; j++) {
        rowCourses.add(j < currSize
            ? _buildCourseTile(
                courses[j]['course_name'], courses[j]['course_id'], context)
            : _buildCompleteCourseTile(
                courses[j]['course_name'], courses[j]['course_id'], context));
        rowCourses.add(const SizedBox(width: 40));
      }
      courseRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowCourses,
        ),
      );
      courseRows.add(const SizedBox(height: 20));
    }
    return Column(children: courseRows);
  }

  Widget _buildCourseTile(String course, int id, BuildContext context) {
    return UnconstrainedBox(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/teacher_courses/course', arguments: {
            'person': person,
            'id': id,
          });
        },
        child: Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(255, 19, 127, 1),
                  Color.fromRGBO(237, 132, 82, 1),
                ]),
          ),
          alignment: Alignment.center,
          child: Text(
            course,
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteCourseTile(String course, int id, BuildContext context) {
    return UnconstrainedBox(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/teacher_courses/course', arguments: {
            'person': person,
            'id': id,
          });
        },
        child: Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: const GradientBoxBorder(
              width: 3,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(255, 19, 127, 1),
                  Color.fromRGBO(237, 132, 82, 1),
                ],
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            course,
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog _notLogged(BuildContext context) {
    return AlertDialog(
      content: const Text('you are not logged in, please try again'),
      title: const Text('Error'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/main', (route) => false);
            },
            child: const Text('Go to main'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        {'person': null}) as Map<String, Person?>;
    if (arguments.values.first != null) {
      person = arguments.values.first;
    }
    return Builder(builder: (context) {
      if (person == null) {
        return _notLogged(context);
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          flexibleSpace: Container(
            height: 100,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                  Color.fromRGBO(40, 1, 84, 1),
                  Color.fromRGBO(75, 0, 95, 81),
                ])),
          ),
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    '../assets/icons/neoflex_logo.png',
                    fit: BoxFit.fitHeight,
                    height: 80,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Neo.edu',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 300,
                  ),
                  Text('${person!.firstName} ${person!.lastName}',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: 700,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/teacher/add_course',
                            arguments: {'person': person});
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromRGBO(40, 1, 84, 1),
                              Color.fromRGBO(75, 0, 95, 81),
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('Добавить курс'),
                      ),
                    ),
                  ),
                ],
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: UnconstrainedBox(
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromRGBO(115, 57, 130, 1),
                            Color.fromRGBO(254, 73, 154, 1),
                          ]),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Курсы',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Builder(
                  builder: (context) {
                    if (person!.completedCourses!.isEmpty &&
                        person!.currentCourses!.isEmpty) {
                      return const Text('No courses');
                    }
                    return FutureBuilder(
                      future: getCoursesName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return _tileBuilder(snapshot.data!,
                            person!.currentCourses!.length, context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
