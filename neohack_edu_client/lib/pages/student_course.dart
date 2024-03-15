import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neohack_edu_client/classes/person.dart';

class StudentCourse extends StatefulWidget {
  const StudentCourse({super.key});

  @override
  State<StudentCourse> createState() => _StudentCourseState();
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

class _StudentCourseState extends State<StudentCourse> {
  Person? person;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        {'person': null}) as Map<String, Person?>;
    if (arguments.values.first != null) {
      person = arguments.values.first;
    }
    log(person?.login ?? 'noLog');
    return Builder(builder: (context) {
      if (person == null) {
        return _notLogged(context);
      }
      return Scaffold(
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
        body: Placeholder(),
      );
    });
  }
}
