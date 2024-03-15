import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _listViewController = ScrollController();

  @override
  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
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
                  width: MediaQuery.of(context).size.width - 300,
                ),
                TextButton(
                  onPressed: () {
                    _listViewController.animateTo(
                      _listViewController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  child: const Text(
                    'Контакты',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          controller: _listViewController,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50),
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    height: 500,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.deepPurple,
                                        width: 5,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.all(30),
                                    child: const Text(
                                      'Желание прокачать мозг${'\n'}приводит на Neo.edu!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 60,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Образовательная платформа Neoflex',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 0,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Column(
                              children: [
                                Image.asset(
                                  '../assets/icons/neoflex_logo.png',
                                  height: 400,
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: <Color>[
                                        Color.fromARGB(255, 40, 1, 84),
                                        Color.fromARGB(207, 75, 0, 95),
                                      ],
                                    ),
                                  ),
                                  child: TextButton(
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(500, 200))),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: const Text(
                                        'Войти',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 70),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 40, 1, 84),
                      Color.fromARGB(207, 75, 0, 95),
                    ],
                  ),
                ),
              ),
              toolbarHeight: 100,
              title: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Служба технической поддержки',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            '8-800-555-35-35',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text('круглосуточно',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                      SizedBox(width: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+7 (495) 984-25-13',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text('info@neoflex.ru',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Адрес',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text('127015, Москва, ул. Вятская, д. 35',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                          Text('стр. 4, 1 подъезд, 2 этаж',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
