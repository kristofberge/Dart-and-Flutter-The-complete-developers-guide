import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import './models/imageModel.dart';
import 'dart:convert';
import './widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    _counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$_counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Let's see some images"),
        ),
        body: Center(
          child: ImageList(images),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImage,
        ),
      ),
    );
  }
}
