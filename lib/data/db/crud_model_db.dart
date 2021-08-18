import 'package:flutter/foundation.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:sqflite/sqflite.dart';

class CrudModelDB {
  final Database db;
  final String tableName;
  CrudModelDB(this.db, this.tableName);

  Future<Map<String, dynamic>> guardar(
      {@required Map<String, Object> modelo}) async {
    int res;
    try {
      res = await db.insert(tableName, modelo);
    } catch (errorsql) {
      print(errorsql.toString());
      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
    return {'${Environment.datosOk}': res};
  }

  Future<Map<String, dynamic>> modifica(
      {@required String where,
      @required List<dynamic> whereArgs,
      @required Map<String, Object> modelo}) async {
    int res = 0;
    try {
      res = await db.update(tableName, modelo,
          where: where, whereArgs: whereArgs);
    } catch (errorsql) {
      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
    return {'${Environment.datosOk}': res};
  }

  Future<Map<String, dynamic>> eliminar(
      {@required String where, @required List<dynamic> whereArgs}) async {
    int res;
    try {
      res = await db.delete(tableName, where: where, whereArgs: whereArgs);
    } catch (errorsql) {
      print(errorsql.toString());
      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
    return {'${Environment.datosOk}': res};
  }

  Future<Map<String, Object>> buscarById(
      {@required String where, @required List<dynamic> whereArgs}) async {
    Map<String, Object> item;
    try {
      final res = await db.query(tableName, where: where, whereArgs: whereArgs);
      if (res.isNotEmpty) item = res.first;
    } catch (errorsql) {
      print(errorsql.toString());
      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
    return {'${Environment.datosOk}': item};
  }

  Future<Map<String, dynamic>> obtenerTodos(
      {String where, List<dynamic> whereArgs, String orderBy}) async {
    try {
      final res = await db.query(tableName,
          where: where, whereArgs: whereArgs, orderBy: orderBy);

      return {'${Environment.datosOk}': res};
    } catch (errorsql) {
      print(errorsql.toString());
      return {'${Environment.errorMensaje}': errorsql.toString()};
    }
  }
}
