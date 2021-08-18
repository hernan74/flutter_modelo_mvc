import 'package:sqflite_common/sqlite_api.dart';

import 'package:flutter_modelo_mvc/data/db/crud_model_db.dart';

class LocalidadDB extends CrudModelDB {
  LocalidadDB(Database db, String tableName) : super(db, tableName);

  Future<List<Map<String, Object>>> obtenerOrdenadoPorNombre() async {
    try {
      final res = await db.query(tableName, orderBy: 'Nombre');

      return res;
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return [];
  }
}
