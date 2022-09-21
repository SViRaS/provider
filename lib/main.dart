import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<RandomColor>.value(value: RandomColor()),
          ],
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Providers',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: 
                Column(
                  children: [const MyStatefulWidget(),
                ]),
              
            ),
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = Provider.of<RandomColor>(context);
     bool _switched = true;
    return Center(
      child: Column(
        children: [
          AnimatedContainer(
            width: 150,
            height: 150,
            color: _randomColor._color,
            duration: const Duration(seconds: 1),
          ),
          Consumer<RandomColor>(builder: (context1, value, child) {
            return Switch(
              value: _switched,
                onChanged: (bool value) {
                  Provider.of<RandomColor>(context, listen: false).rand();
                  setState(() {
                    _switched != _switched;
                  });
                },
                
                );
                
          })
        ],
      ),
    );
  }
}

class RandomColor extends ChangeNotifier {
  final Random _random = Random();

  Color randColor() {
    return Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
        _random.nextInt(256), _random.nextInt(256));
  }

  Color _color = Color.fromARGB(70, 100, 200, 250);

  Color get randomColor => _color;

  void rand() {
    _color = randColor();
    notifyListeners();
  }
}

