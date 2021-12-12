import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

void main() {
  runApp(new MaterialApp(home: Quotes()));
}

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  String quotes = "Click the button to generate quotes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zen Quotes Generator"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(quotes),
            TextButton.icon(
                onPressed: _generateQuote,
                icon: Icon(Icons.wb_sunny),
                label: Text("Generate Quote"))
          ],
        ),
      ),
    );
  }

  _generateQuote() async {
    var response = await Dio().get("https://zenquotes.io/api/random");
    String quote = response.data.toString().split('"')[3];
    String author = response.data.toString().split('"')[7];
    setState(() {
      quotes = "${quote}\n-${author}";
    });

    print(author);
  }
}
