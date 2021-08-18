import 'package:flutter_modelo_mvc/data/localidades/localidad_data.dart';
import 'package:flutter_modelo_mvc/data/localidades/localidad_db.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/localidad_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalidadDataImpl implements LocalidadData {
  final Future<Database> database;

  LocalidadDataImpl(this.database);

  @override
  Future<Map<String, dynamic>> buscarById(int id) async {
    if (id == null)
      return {'${Environment.errorMensaje}': 'Criterio no puede ser null'};
    final LocalidadDB db =
        new LocalidadDB(await database, '${Environment.tablaLocalidad}');
    return await db.buscarById(where: 'Id=?', whereArgs: [id]);
  }

  @override
  Future<Map<String, dynamic>> eliminar(int id) async {
    if (id == null || id < 1)
      return {'${Environment.errorMensaje}': 'Criterio no puede ser null'};
    final LocalidadDB db =
        new LocalidadDB(await this.database, '${Environment.tablaLocalidad}');

    return await db.eliminar(where: 'Id=?', whereArgs: [id]);
  }

  @override
  Future<Map<String, dynamic>> guardar(LocalidadModel modelo) async {
    if (modelo == null || modelo.nombre == null)
      return {'${Environment.errorMensaje}': 'Debe ingresar un nombre'};
    final LocalidadDB db =
        new LocalidadDB(await this.database, '${Environment.tablaLocalidad}');
    Map<String, Object> personaToJson = modelo.toJson();

    return await db.guardar(modelo: personaToJson);
  }

  @override
  Future<Map<String, dynamic>> modificar(LocalidadModel modelo) async {
    if (modelo == null || modelo.id == null || modelo.nombre == null)
      return {
        '${Environment.errorMensaje}': 'No se puede modificar el registro'
      };
    final LocalidadDB db =
        new LocalidadDB(await this.database, '${Environment.tablaLocalidad}');
    return db.modifica(
        where: 'Id=?', whereArgs: [modelo.id], modelo: modelo.toJson());
  }

  @override
  Future<Map<String, dynamic>> obtenerTodos() async {
    final LocalidadDB db =
        new LocalidadDB(await this.database, '${Environment.tablaLocalidad}');

    return await db.obtenerTodos(orderBy: 'Nombre');
  }
}
