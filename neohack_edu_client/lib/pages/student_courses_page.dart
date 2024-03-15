import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neohack_edu_client/classes/person.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({Key? key, this.person});

  Person? person;

  Widget _tileBuilder(List<String> currCourses, List<String> compCourses) {
    List<Widget> courseRows = [const SizedBox(width: 40)];
    List<String> courses = currCourses.toString() as List<String>;
    courses.addAll(compCourses);
    for (int i = 0; i < courses.length; i += 3) {
      List<Widget> rowCourses = [];
      rowCourses.add(const SizedBox(width: 40));
      for (int j = i; j < i + 3 && j < courses.length; j++) {
        rowCourses.add(j < currCourses.length
            ? _buildCourseTile(courses[j])
            : _buildCompleteCourseTile(courses[j]));
        rowCourses.add(const SizedBox(width: 40));
      }
      courseRows.add(
        Row(
          children: rowCourses,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      );
      courseRows.add(const SizedBox(height: 20));
    }
    return Column(children: courseRows);
  }

  Widget _buildCourseTile(String course) {
    return UnconstrainedBox(
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteCourseTile(String course) {
    return UnconstrainedBox(
      child: Container(
        height: 150,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: const GradientBoxBorder(
            gradient: const LinearGradient(
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
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  AlertDialog _notLogged(BuildContext context) {
    return AlertDialog(
      content: Text('you are not logged in, please try again'),
      title: Text('Error'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/main', (route) => false);
            },
            child: Text('Go to main'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? '')
        as Map<String, Person>;
    log(arguments.values.first.firstName!);
    // if (arguments) {
    //   person = arguments['person'];
    // } else {
    //   person = null;
    // }
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
          minimum: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 60),
              FittedBox(
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
                    child: Text(
                      'Курсы',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 120),
              FittedBox(
                child: _tileBuilder(
                    person!.currentCourses!, person!.completedCourses!),
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ),
      );
    });
  }
}
