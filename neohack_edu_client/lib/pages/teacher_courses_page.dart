import 'package:flutter/material.dart';

class TeachCoursesPage extends StatelessWidget {
  TeachCoursesPage({Key? key, String personName = 'Annastasiya Lejvchekina'})
      : _personName = personName,
        super(key: key);

  final String _personName;
  final List<String> _personCourses = [
    'Курс 1',
    'Курс 2',
    'Курс 3',
    'Курс 4',
    'Курс 5',
    'Курс 6',
    'Курс 7',
    'Курс 8',
    'Курс 9',
    'Курс 10',
  ];

  Widget _tileBuilder(BuildContext context, List<String> courses) {
    List<Widget> courseRows = [const SizedBox(width: 40)];
    for (int i = 0; i < _personCourses.length; i += 3) {
      List<Widget> rowCourses = [];
      rowCourses.add(const SizedBox(width: 40));
      for (int j = i; j < i + 3 && j < _personCourses.length; j++) {
        rowCourses.add(_buildCourseTile(context, _personCourses[j]));
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

  Widget _buildCourseTile(BuildContext context, String course) {
    return UnconstrainedBox(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/teacher_courses/course',
              arguments: course);
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Text('$_personName',
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
              child: _tileBuilder(context, _personCourses),
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ),
    );
  }
}
