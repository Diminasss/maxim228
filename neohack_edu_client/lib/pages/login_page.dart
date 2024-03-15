import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String URI = 'http://localhost:5000';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _focusNextField(
      BuildContext context, FocusNode curr, FocusNode nextFocus) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<bool> _isLoginSuccess(String login, String pass) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'login': login,
        'password': pass,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'];
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess =
          await _isLoginSuccess(_nameController.text, _passwordController.text);
      if (isSuccess) {
        CookieJar cookies = CookieJar();
        cookies.saveFromResponse(
            Uri.parse('$URI/login'), [Cookie('login', _nameController.text)]);
        log(cookies.toString());
        Navigator.pushNamed(context, '/teacher_courses');
      } else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text('No user')),
          duration: Duration(seconds: 2),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 40, 1, 84),
                  Color.fromARGB(207, 75, 0, 95),
                ],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            height: 500,
            width: 300,
            alignment: Alignment.center,
            child: SafeArea(
              minimum: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Авторизация',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CupertinoTextFormFieldRow(
                      controller: _nameController,
                      placeholder: 'Введите логин',
                      prefix: const Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 10),
                        ],
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _nameFocusNode,
                      cursorColor: const Color.fromARGB(207, 75, 0, 95),
                      style: const TextStyle(
                          color: Color.fromARGB(207, 75, 0, 95),
                          fontWeight: FontWeight.bold),
                      placeholderStyle: const TextStyle(
                          color: Color.fromARGB(207, 75, 0, 95),
                          fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onEditingComplete: () {
                        _focusNextField(
                            context, _nameFocusNode, _passwordFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите логин';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextFormFieldRow(
                      placeholder: 'Введите пароль',
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      prefix: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.white),
                          SizedBox(width: 10),
                        ],
                      ),
                      cursorColor: const Color.fromARGB(207, 75, 0, 95),
                      style: const TextStyle(
                          color: Color.fromARGB(207, 75, 0, 95),
                          fontWeight: FontWeight.bold),
                      placeholderStyle: const TextStyle(
                          color: Color.fromARGB(207, 75, 0, 95),
                          fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onEditingComplete: () {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 180),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: CupertinoButton(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: () {
                          _saveForm();
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
