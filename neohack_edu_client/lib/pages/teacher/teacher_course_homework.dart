import 'package:flutter/material.dart';
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

class HomeworkStatistic extends StatelessWidget {
  HomeworkStatistic({super.key, person, courseId});

  Person? person;

  int? courseId;

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
    courseId = arguments['id'];

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
      body: Center(
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Row 1, Cell 1')),
                ),
                TableCell(
                  child: Center(child: Text('Row 1, Cell 2')),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Row 2, Cell 1')),
                ),
                TableCell(
                  child: Center(child: Text('Row 2, Cell 2')),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Row 3, Cell 1')),
                ),
                TableCell(
                  child: Center(child: Text('Row 3, Cell 2')),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Row 4, Cell 1')),
                ),
                TableCell(
                  child: Center(child: Text('Row 4, Cell 2')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
