class AppSettings {
  final int? id;
  final String nomeAnalista;

  AppSettings({
    this.id,
    required this.nomeAnalista,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_analista': nomeAnalista,
    };
  }

  factory AppSettings.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppSettings(
      id: map['id'],
      nomeAnalista: map['nome_analista'] ?? '',
    );
  }
}