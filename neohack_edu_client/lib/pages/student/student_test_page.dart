import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:neohack_edu_client/classes/person.dart';

class StudentTestPage extends StatelessWidget {
  StudentTestPage({super.key, person, curseId});

  Person? person;
  int? testId;

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

  Future<dynamic> getTestName(login, testId) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/test'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'login': login,
        'test_id': [testId],
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
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: getTestName(person!.login, testId),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              var testInfo = snapshot.data!;
              return Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: UnconstrainedBox(
                      child: Container(
                        height: 100,
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
                          'Домашнее задание',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: UnconstrainedBox(
                      child: Container(
                        height: 150,
                        width: 700,
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
                          testInfo['test_name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
