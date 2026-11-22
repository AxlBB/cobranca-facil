import 'package:flutter/material.dart';

import 'database/database_helper.dart';
import 'repositories/settings_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  final repository = SettingsRepository();

  await repository.salvarAnalista(
    'Alex Barbosa',
  );

  final settings =
      await repository.obter();

  print(
    'Analista: ${settings.nomeAnalista}',
  );

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