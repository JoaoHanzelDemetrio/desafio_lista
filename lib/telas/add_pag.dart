import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController exercicioController = TextEditingController();
  TextEditingController serierepController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar exercicio'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextField(
            controller: exercicioController,
            decoration: InputDecoration(hintText: 'Exercicio'),
          ),
          TextField(
            controller: serierepController,
            decoration: InputDecoration(hintText: 'Nº de Series e Nº de repetições'),
          ),
        
          ElevatedButton(onPressed: submitData, child: Text('Adicionar'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final exercicio = exercicioController.text;
    final serierep = serierepController.text;
 
    final body = {
      "title": exercicio,
      "description": serierep,
      "is_completed": false,
    };

    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode == 201){
      print('Adicionado!');
      showSucessMessage('Adicionado!');

    }else {
      print('Erro ao adicionar!');
      print(response.body);
      showErrorMessage('Erro ao adicionar!');
    }

    
  }
  void showSucessMessage(String message){
      final snackBar = SnackBar(content: Text(message),
        backgroundColor: const Color.fromARGB(255, 97, 187, 100),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message){
      final snackBar = SnackBar(content: Text(
        message,
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}