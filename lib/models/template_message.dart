class TemplateMessage {
  final int? id;
  final String nome;
  final String conteudo;
  final DateTime criadoEm;
  final DateTime? atualizadoEm;

  TemplateMessage({
    this.id,
    required this.nome,
    required this.conteudo,
    required this.criadoEm,
    this.atualizadoEm,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'conteudo': conteudo,
      'criado_em': criadoEm.toIso8601String(),
      'atualizado_em': atualizadoEm?.toIso8601String(),
    };
  }

  factory TemplateMessage.fromMap(
    Map<String, dynamic> map,
  ) {
    return TemplateMessage(
      id: map['id'],
      nome: map['nome'],
      conteudo: map['conteudo'],
      criadoEm: DateTime.parse(
        map['criado_em'],
      ),
      atualizadoEm: map['atualizado_em'] != null
          ? DateTime.parse(
              map['atualizado_em'],
            )
          : null,
    );
  }
}