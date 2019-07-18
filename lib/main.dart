import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'My Test', storage: CounterStorage(),),
    );
  }
}
// class GetData
// {
//   Futrue<http.Response> fetchData(http.Client client) async {
//     return client.get("https://jsonplaceholder.typicode.com/photos");
//   }

// }
class CounterStorage {
  Future <String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future <File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    }
    catch(e)
    {
      return 0;
    }
  }
  Future<File> writeCounter(int i) async {
    final file = await _localFile;
    return file.writeAsString('$i');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.storage}) : super(key: key);
  final String title;
  final CounterStorage storage;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter;

  @override
  void initState()
  {
      super.initState();
      widget.storage.readCounter().then((int value){
          setState(() {
            _counter = value;
          });
      });
      
  }
  Future<File> _incrementCounter() async {
    setState(() {
      
      _counter++;
    });
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: _counter,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(FontAwesomeIcons.stepForward),
            title: Text('Name of the item $_counter'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {

    return Scaffold(appBar: AppBar(
      title: Text("Second Screen")
      ),
      body: Center(
        child: RaisedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text("go back"),
          icon: new Icon(FontAwesomeIcons.stepBackward),
      ),
      ),
      );
  }
}
