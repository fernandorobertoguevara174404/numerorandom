import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Números aleatorios',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Números aleatorios'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _randomNumber = 0;
  double _currentSliderValue = 0;
  List<int>? _randomNumbers;
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  var rng = new Random();

  int nextRandom(int index){
    int range = _currentRangeValues.end.toInt() - _currentRangeValues.start.toInt() + 1;
    return _currentRangeValues.start.toInt() + rng.nextInt(range);
  }

  void _generateRandom() {
    setState(() {
      _randomNumbers = List<int>.generate(10, nextRandom);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 100,
            divisions: 100,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
            }); }
          ),
            Expanded(child: _randomNumbers == null?
              Text("No hay número")
              :ListView.builder(
                itemCount: _randomNumbers?.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text("" + _randomNumbers![index].toString()),
              );
            })
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandom,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
