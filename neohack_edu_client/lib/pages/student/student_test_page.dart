import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:neohack_edu_client/classes/person.dart';

class StudentTestPage extends StatefulWidget {
  StudentTestPage({super.key, person, curseId});

  @override
  State<StudentTestPage> createState() => _StudentTestPageState();
}

class _StudentTestPageState extends State<StudentTestPage> {
  Person? person;

  int? testId;

  final _textField = TextEditingController();

  Future<String> sendRep(login, testId, rep) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/checkhomework'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': login,
        'test_id': testId,
        'repo_url': rep,
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      var answer = jsonDecode(response.body)['response'];
      return answer;
    } else {
      throw Exception('Failed to fetch data.');
    }
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

  AlertDialog _result(BuildContext context, String result) {
    return AlertDialog(
      content: Text('You\'r result is $result'),
      title: const Text('Result'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back'))
      ],
    );
  }

  Future<dynamic> getTestName(login, testId) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/test'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': login,
        'test_id': testId,
      }),
    );

    if (response.statusCode == 200) {
      var answer = (jsonDecode(response.body));
      return answer;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        {'person': null, 'id': 0}) as Map<String, dynamic>;

    if (arguments['person'] == null ||
        arguments['id'] == 0 ||
        arguments['id'] == null) {
      return _notLogged(context);
    }

    person = arguments['person'];
    testId = arguments['id'];

    bool isResult = false;

    late final String result;

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
                Text(
                  '${person!.firstName} ${person!.lastName}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            FutureBuilder(
              future: getTestName(person!.login, testId),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                var testInfo = snapshot.data!;
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UnconstrainedBox(
                        child: Container(
                          height: 60,
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
                            'Домашнее задание',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UnconstrainedBox(
                        child: Container(
                          height: 60,
                          width: 600,
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
                            testInfo['test_name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        width: 600,
                        padding: const EdgeInsets.all(30),
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
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          readOnly: true,
                          initialValue: testInfo['test_text'],
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.justify,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              maxLines: 1,
                              controller: _textField,
                              decoration: InputDecoration(
                                  icon: Text(
                                    'Ссылка на репозиторий',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  counterText: isResult ? result : '',
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide())),
                              textAlign: TextAlign.justify,
                              textAlignVertical: TextAlignVertical.top,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              padding:
                                  const EdgeInsets.only(right: 20, left: 15),
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
                                  'Отправить',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  String answer = await sendRep(
                                      person!.login, testId, _textField.text);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(answer),
                                    backgroundColor: Colors.purple,
                                  ));
                                  result = answer;
                                  isResult = true;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
