import 'package:flutter/material.dart';
import 'package:flutter_app/ParserISO.dart';

ParserISO parser = new ParserISO();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mensaje;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("iso Parser"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ISO message',
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return 'El campo está vacío.';
                } else {
                  return null;
                }
              },
              onChanged: (val) {
                setState(() {
                  mensaje = val;
                  parser.unParsedMessage = val;
                });
              },
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.amber,
              child: Text("Parse"),
              onPressed: () {
                parser.initParse(mensaje);
                },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
