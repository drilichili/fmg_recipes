import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

List<dynamic> _items = [];

Future<dynamic> _loadData() async {
  String data = await rootBundle.loadString('assets/example_my_recipe.json');
  Map<String, dynamic> jsonData = jsonDecode(data);
  List<dynamic> recipes = (jsonData['data']['recipes']);
  //print(recipes);
  List<dynamic> firstRecipeIngredients = recipes[0]['ingredients'];
  var rawFirstRecipeYields = recipes[0]['yields_json'];
  var firstRecipeYields = jsonDecode(rawFirstRecipeYields);

  firstRecipeIngredients.forEach((element) {
    print(element['ingredients']['id']);
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  List<String> recipes = List.generate(100, (index) => 'placeholder, $index');

  void initState() {
    _loadData();
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MaterialButton(onPressed: () {
              _loadData();
            }),
            const Text(
              'Hello User!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipes.length,
                itemBuilder: (BuildContext context, int index) => Text(
                  '$index',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
