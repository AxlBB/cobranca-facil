import '../database/database_helper.dart';
import '../models/template_message.dart';

class TemplateRepository {

  Future<List<TemplateMessage>> listar() async {

    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      'templates',
      orderBy: 'nome ASC',
    );

    return result
        .map(
          (e) => TemplateMessage.fromMap(e),
        )
        .toList();
  }

  Future<int> inserir(
    TemplateMessage template,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.insert(
      'templates',
      template.toMap(),
    );
  }

  Future<int> excluir(
    int id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.delete(
      'templates',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}