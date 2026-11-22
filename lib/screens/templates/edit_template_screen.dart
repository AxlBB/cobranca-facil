import 'package:flutter/material.dart';

import '../../models/template_message.dart';
import '../../repositories/template_repository.dart';

class EditTemplateScreen extends StatefulWidget {
  const EditTemplateScreen({super.key});

  @override
  State<EditTemplateScreen> createState() =>
      _EditTemplateScreenState();
}

class _EditTemplateScreenState
    extends State<EditTemplateScreen> {

  final _nomeController =
      TextEditingController();

  final _conteudoController =
      TextEditingController();

  final _repository =
      TemplateRepository();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Template',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Template',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _conteudoController,
              minLines: 8,
              maxLines: 12,
              decoration: const InputDecoration(
                labelText: 'Mensagem',
                border: OutlineInputBorder(),
                hintText:
                    'Digite o conteúdo do template',
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  if (_nomeController.text
                      .trim()
                      .isEmpty) {
                    return;
                  }

                  if (_conteudoController.text
                      .trim()
                      .isEmpty) {
                    return;
                  }

                  final template =
                      TemplateMessage(
                    nome:
                        _nomeController.text.trim(),
                    conteudo:
                        _conteudoController.text.trim(),
                    criadoEm: DateTime.now(),
                  );

                  await _repository.inserir(
                    template,
                  );

                  if (!mounted) return;

                  Navigator.pop(context);
                },
                child: const Text(
                  'SALVAR',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}