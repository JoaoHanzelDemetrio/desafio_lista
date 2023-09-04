import 'dart:convert';

import 'package:desafio_lista/telas/add_pag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List items = [];

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de exercicios'),
      ),
      
      body: RefreshIndicator(
        onRefresh:fetchList,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            final item = items[index] as Map;
            return CheckboxListTile(
              
              title: Text(item['title']),
              subtitle: Text(item['description']),
              controlAffinity: ListTileControlAffinity.leading,
              value: item['is_completed'], onChanged: (bool? value) {
                setState(() {
                  item['is_completed'] = value!;
                });
               },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add'),
      ),
    );
  }

  void navigateToAddPage(){
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    Navigator.push(context, route);
  }

  Future<void> fetchList() async {
    print(items.length);
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final lista = json['items'] as List;
      setState(() {
        items = lista;
      });
    }else {

    }
    print(response.statusCode);
    print(response.body);

  }
}