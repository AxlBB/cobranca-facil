import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobrança Fácil',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cobrança Fácil'),
        ),
        body: const Center(
          child: Text(
            'Projeto iniciado com sucesso!',
          ),
        ),
      ),
    );
  }
}
