import 'package:flutter/material.dart';
import 'myappbar.dart';
import 'myappbody.dart';
import 'add.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
      fontFamily: 'Montserrat',
    ),
    routes: {
      '/': (context) => MyApp(),
      '/add': (context) => Add(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: MyAppBar(),
        body: MyAppBody(),
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          width: 48,
          height: 48,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Color(0xFF22A5A6),
              child:const Image(
                  image: AssetImage('assets/Images/plus.png'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
            ),
          ),
        )
      );
  }
}