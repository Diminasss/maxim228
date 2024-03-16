import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:neohack_edu_client/classes/person.dart';

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

class TeacherAddCourse extends StatelessWidget {
  TeacherAddCourse({super.key, person, courseId});

  Person? person;

  int? courseId;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        {'person': null}) as Map<String, dynamic>;

    if (arguments['person'] == null) {
      return _notLogged(context);
    }

    person = arguments['person'];
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
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            UnconstrainedBox(
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
                    ],
                  ),
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
            const SizedBox(height: 80),
            Container(
              height: 120,
              width: 600,
              padding: const EdgeInsets.only(right: 20, left: 15),
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
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    icon: Text(
                      'Название курса',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    border: UnderlineInputBorder(borderSide: BorderSide())),
                textAlign: TextAlign.justify,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 160,
              width: 300,
              padding: const EdgeInsets.only(right: 20, left: 15),
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
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        icon: Text(
                          'Лекция',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        border: UnderlineInputBorder(borderSide: BorderSide())),
                    textAlign: TextAlign.justify,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.only(right: 20, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color.fromRGBO(255, 19, 127, 1),
                          Color.fromRGBO(237, 132, 82, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Добавить',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 150,
              padding: const EdgeInsets.only(right: 20, left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(255, 19, 127, 1),
                    Color.fromRGBO(237, 132, 82, 1),
                  ],
                ),
              ),
              child: TextButton(
                child: const Text(
                  'Теория',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 150,
              padding: const EdgeInsets.only(right: 20, left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(255, 19, 127, 1),
                    Color.fromRGBO(237, 132, 82, 1),
                  ],
                ),
              ),
              child: TextButton(
                child: const Text(
                  'Практика',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 800,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.only(right: 20, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color.fromRGBO(255, 19, 127, 1),
                          Color.fromRGBO(237, 132, 82, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
