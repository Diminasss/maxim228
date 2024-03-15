import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:neohack_edu_client/colorscheme/color_schemes.g.dart';
import 'package:neohack_edu_client/pages/student_courses_page.dart';
import 'package:neohack_edu_client/pages/login_page.dart';
import 'package:neohack_edu_client/pages/main_page.dart';
import 'package:neohack_edu_client/pages/teacher_course.dart';
import 'package:neohack_edu_client/pages/teacher_courses_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
    darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    home: MainPage(),
    initialRoute: '/main',
    routes: {
      '/main': (context) => MainPage(),
      '/login': (context) => const LoginPage(),
      '/student_courses': (context) => CoursesPage(),
      '/teacher_courses': (context) => TeachCoursesPage(),
      '/teacher_courses/course': (context) => TeacherCourse(),
      //TODO implement course page
    },
  ));
}
