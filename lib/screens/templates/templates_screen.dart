import 'package:flutter/material.dart';

import '../../models/template_message.dart';
import '../../repositories/template_repository.dart';
import 'edit_template_screen.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() =>
      _TemplatesScreenState();
}

class _TemplatesScreenState
    extends State<TemplatesScreen> {

  final _repository =
      TemplateRepository();

  List<TemplateMessage> templates = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregarTemplates();
  }

  Future<void> carregarTemplates() async {

    final lista =
        await _repository.listar();

    setState(() {
      templates = lista;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Templates',
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const EditTemplateScreen(),
            ),
          );

          await carregarTemplates();
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : templates.isEmpty

              ? const Center(
                  child: Text(
                    'Nenhum template cadastrado',
                  ),
                )

              : ListView.builder(
                  itemCount:
                      templates.length,
                  itemBuilder:
                      (context, index) {

                    final template =
                        templates[index];

                    return ListTile(
                      title: Text(
                        template.nome,
                      ),

                      subtitle: Text(
                        template.conteudo,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
    );
  }
}