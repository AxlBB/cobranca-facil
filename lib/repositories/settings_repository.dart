import '../database/database_helper.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  Future<AppSettings> obter() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'settings',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );

    return AppSettings.fromMap(
      result.first,
    );
  }

  Future<void> salvarAnalista(
    String nome,
  ) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      'settings',
      {
        'nome_analista': nome,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}