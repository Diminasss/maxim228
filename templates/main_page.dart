import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Container(
          alignment: Alignment.centerRight,
          width: 200,
          child: Icon(
            Icons.local_dining_outlined,
            size: 80,
          ),
        ),
        leadingWidth: 180,
        title: Text(
          'Neo.edu',
          style: TextStyle(fontSize: 60),
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: SafeArea(
          minimum: EdgeInsets.all(120),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          'Желание прокачать мозг${'\n'}приводит на Neo.edu!',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
