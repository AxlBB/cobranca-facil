import 'package:flutter/material.dart';

import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  runApp(
    const MyApp(),
  );
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
          title: const Text(
            'Cobrança Fácil',
          ),
        ),
        body: const Center(
          child: Text(
            'Banco SQLite inicializado com sucesso!',
          ),
        ),
      ),
    );
  }
}