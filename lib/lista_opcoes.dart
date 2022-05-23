// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:ex_flutter_v2/corDados.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaOpcoes extends StatefulWidget {

  @override
  State<ListaOpcoes> createState() => _ListaOpcoesState();
  
}

const URLbase = 'https://7c2bad50.us-south.apigw.appdomain.cloud/api/guessColors';

class _ListaOpcoesState extends State<ListaOpcoes> {

  //int r = 0, g = 0, b = 0, a = 0, correto = 0;
  //List<String> opcoes = [];
  
  Dados _data = Dados.empty();
  int _selectedOption = -1;

  @override
  void initState() {

    var response = http.get(Uri.parse(URLbase)).then((resposta) {
      final aux = jsonDecode(resposta.body);
      
      setState(() {

        _data.a = aux['a'];
        _data.r = aux['r'];
        _data.g = aux['g'];
        _data.b = aux['b'];
        _data.correto = aux['correto'];
        _data.opcoes = List<String>.from(aux['opcoes']);
        
      });
            
    });

  } 

  Widget listarOpcoes() {
    return Column(children: List<Widget>.from(_data.opcoes.map((option) {
      int index = _data.opcoes.indexOf(option);
      return ListTile(
        title: Text(option),
        leading: Radio<int>(
            value: index,
            groupValue: _selectedOption,
            onChanged: (int? value) {
              setState(() {
                _selectedOption = value!;
              });
            }),
      );
    })));
  }

  void recomecar() {
    initState();
  }

  void checar() {
    String result = _selectedOption == _data.correto ? "Correta!" : "Incorreta";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sua escolha está...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(result)],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Ir para o próximo'),
                onPressed: () {
                  Navigator.of(context).pop();
                  recomecar();
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Adivinhe as cores"),
        centerTitle: true,
      ),
      body: // statefull component
      Column(children: <Widget>[
        Container(
          height: 150, 
          color: 
            Color.fromARGB(_data.a, _data.r, _data.g, _data.b)
        ),
        Expanded(
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Center(
                child: Text("Tente adivinhar as cores:"),
              ),
              listarOpcoes(),
              Center(
                child: ElevatedButton(
                  child: Text("Confirmar escolha"),
                  onPressed: checar,
                ),
              )
            ]
          ),
        ))
      ]),
    )
    );
  }

}