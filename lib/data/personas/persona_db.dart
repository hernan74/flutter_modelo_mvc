import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'package:flutter_modelo_mvc/data/db/crud_model_db.dart';

class PersonaDB extends CrudModelDB {
  PersonaDB(Database db, String tableName) : super(db, tableName);

  Future<Map<String, dynamic>> obtenerPersonaPorLocalidad(
      int idLocalidad) async {
    try {
      final res = await db.query(tableName,
          where: 'idLocalidad = ?',
          whereArgs: [idLocalidad],
          orderBy: 'Nombre');

      return {'${Environment.datosOk}': res};
    } catch (errorsql) {
      print(errorsql.toString());

      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
  }
}
