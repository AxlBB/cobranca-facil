import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';
import '../templates/templates_screen.dart';
import '../../models/app_settings.dart';
import '../../models/template_message.dart';
import '../../repositories/settings_repository.dart';
import '../../repositories/template_repository.dart';
import '../../services/template_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final _settingsRepository =
      SettingsRepository();

  final _templateRepository =
      TemplateRepository();

  final _telefoneController =
      TextEditingController();

  final _nomeController =
      TextEditingController();

  final _empresaController =
      TextEditingController();

  List<TemplateMessage> _templates = [];

  TemplateMessage? _templateSelecionado;

  String _analista = '';

  String _mensagemGerada = '';

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {

    final AppSettings settings =
        await _settingsRepository.obter();

    final templates =
        await _templateRepository.listar();

    setState(() {
      _analista =
          settings.nomeAnalista;

      _templates = templates;

      if (templates.isNotEmpty) {
        _templateSelecionado =
            templates.first;
      }

      _loading = false;
    });

    gerarMensagem();
  }

  void gerarMensagem() {

    if (_templateSelecionado == null) {
      return;
    }

    final mensagem =
        TemplateService.processar(
      template:
          _templateSelecionado!.conteudo,
      analista: _analista,
      nome: _nomeController.text,
      empresa:
          _empresaController.text,
    );

    setState(() {
      _mensagemGerada = mensagem;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cobrança Fácil',
        ),
        actions: [

          IconButton(
            icon: const Icon(
              Icons.article,
            ),
            tooltip: 'Templates',
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const TemplatesScreen(),
                ),
              );

              await carregarDados();
            },
          ),

          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            tooltip: 'Configurações',
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SettingsScreen(),
                ),
              );

              await carregarDados();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            TextField(
              controller:
                  _telefoneController,
              decoration:
                  const InputDecoration(
                labelText: 'Telefone',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  _nomeController,
              onChanged: (_) =>
                  gerarMensagem(),
              decoration:
                  const InputDecoration(
                labelText: 'Nome',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  _empresaController,
              onChanged: (_) =>
                  gerarMensagem(),
              decoration:
                  const InputDecoration(
                labelText: 'Empresa',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<
                TemplateMessage>(
              value:
                  _templateSelecionado,
              decoration:
                  const InputDecoration(
                labelText: 'Template',
                border:
                    OutlineInputBorder(),
              ),
              items: _templates
                  .map(
                    (template) =>
                        DropdownMenuItem(
                      value: template,
                      child: Text(
                        template.nome,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (template) {

                setState(() {
                  _templateSelecionado =
                      template;
                });

                gerarMensagem();
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Mensagem Gerada',
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius:
                    BorderRadius.circular(
                  8,
                ),
              ),
              child: Text(
                _mensagemGerada,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: gerarMensagem,
                child: const Text(
                  'GERAR',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}