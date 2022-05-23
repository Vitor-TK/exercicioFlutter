import 'dart:html';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'lista_opcoes.dart';

void main() {
  // flutter run --no-sound-null-safety
  runApp(AdvCores());
}

class AdvCores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(seconds: 5, 
    title: const Text('!Adivinhe as Cores!', 
      style: TextStyle(color: Colors.blue, 
      fontWeight: FontWeight.bold, 
      fontSize: 20)
      ), 
    navigateAfterSeconds: ListaOpcoes(),
    image: Image.network('https://cdn.pixabay.com/photo/2016/03/08/07/08/question-1243504_1280.png'),
    photoSize: 100,
    backgroundColor: Colors.yellow,)
    );
  }
}