import 'dart:async';

import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<String> streamController = StreamController<String>();
  String nome = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    streamController.stream.listen(
      (success) async {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        setState(() {
          nome = success;
          isLoading = false;
        });
      },
      onError: (error) {
        setState(() {
          isLoading = false;
        });
      },
    );
    streamController.sink.add('Bruno');
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
            isLoading ? const CircularProgressIndicator() : Text(nome),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }
}
