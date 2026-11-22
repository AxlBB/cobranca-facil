import 'package:flutter/material.dart';

import '../../models/app_settings.dart';
import '../../repositories/settings_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  final _repository =
      SettingsRepository();

  final _controller =
      TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {

    final AppSettings settings =
        await _repository.obter();

    _controller.text =
        settings.nomeAnalista;

    setState(() {
      _loading = false;
    });
  }

  Future<void> _salvar() async {

    await _repository.salvarAnalista(
      _controller.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Configuração salva com sucesso!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cobrança Fácil',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              'Nome do Analista',
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(
                border:
                    OutlineInputBorder(),
                hintText:
                    'Digite seu nome',
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvar,
                child:
                    const Text('SALVAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}