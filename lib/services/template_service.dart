class TemplateService {

  static String processar({
    required String template,
    String? analista,
    String? nome,
    String? empresa,
  }) {

    String resultado = template;

    resultado = resultado.replaceAll(
      '{ANALISTA}',
      analista ?? '',
    );

    resultado = resultado.replaceAll(
      '{NOME}',
      nome ?? '',
    );

    resultado = resultado.replaceAll(
      '{EMPRESA}',
      empresa ?? '',
    );

    return resultado;
  }
}