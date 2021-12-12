import 'package:flutter/material.dart';
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
        title: Text("Quotes Generator"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                  width: 350,
                  height: 200,
                  margin: EdgeInsets.all(30.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    quotes,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade100,
                        fontStyle: FontStyle.italic),
                  ))),
            ),
            Divider(
              thickness: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton.icon(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.lightBlue),
                  onPressed: _generateQuote,
                  icon: Icon(
                    Icons.light_mode_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Generate Quote",
                    style: TextStyle(color: Colors.grey.shade100, fontSize: 19),
                  )),
            ),
            Spacer()
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
      quotes = '''${quote}

                     -${author}''';
    });
  }
}
