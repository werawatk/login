import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  int _counter = 0;

  void CounterAdd() {
    setState(() {
      _counter++;
    });
  }

  void Renew() {
    setState(() {
      _counter = 0;
    });
  }

  void CounterRemove() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Counter IT'),
        leading: Icon(Icons.home),
        actions: [Icon(Icons.exit_to_app)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'นับจำนวนตัวเลขเพิ่มหรือลด',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 100, color: Colors.green),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: CounterAdd,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: Renew,
            child: Icon(Icons.cached),
            backgroundColor: Colors.red,
          ),
          FloatingActionButton(
            onPressed: CounterRemove,
            child: Icon(Icons.remove),
            backgroundColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}
