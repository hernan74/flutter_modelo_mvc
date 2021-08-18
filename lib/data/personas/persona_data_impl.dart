import 'package:flutter_modelo_mvc/data/db/dbase.dart';
import 'package:flutter_modelo_mvc/data/personas/persona_data.dart';
import 'package:flutter_modelo_mvc/data/personas/persona_db.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/persona_model.dart';

class PersonaDataImpl implements PersonaData {
  @override
  Future<Map<String, dynamic>> eliminar(int idPersona) async {
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');
    if (idPersona == null || idPersona < 1)
      return {'${Environment.errorMensaje}': 'Id no puede ser null'};
    Map<String, dynamic> resp =
        await db.eliminar(where: 'Id = ?', whereArgs: [idPersona]);
    return resp;
  }

  @override
  Future<Map<String, dynamic>> guardar(PersonaModel modelo) async {
    if (modelo == null || modelo.nombre == null || modelo.nombre.isEmpty)
      return {'${Environment.errorMensaje}': 'Debe ingresar un nombre'};
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');
    Map<String, Object> personaToJson = modelo.toJson();

    return await db.guardar(modelo: personaToJson);
  }

  Future<Map<String, dynamic>> buscarById(int id) async {
    if (id == null)
      return {'${Environment.errorMensaje}': 'Debe ingresar un id'};
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');
    return await db.buscarById(where: 'id=?', whereArgs: [id]);
  }

  @override
  Future<Map<String, dynamic>> modificar(PersonaModel modelo) async {
    if (modelo == null || modelo.id == null || modelo.nombre == null)
      return {
        '${Environment.errorMensaje}': 'No se puede modificar el registro'
      };
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');
    return await db.modifica(
        where: 'Id=?', whereArgs: [modelo.id], modelo: modelo.toJson());
  }

  @override
  Future<Map<String, dynamic>> obtenerTodos() async {
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');

    return await db.obtenerTodos(orderBy: 'Nombre ');
  }

  @override
  Future<Map<String, dynamic>> obtenerPersonaPorLocalidad(
      int idLocalidad) async {
    if (idLocalidad == null)
      return {'${Environment.errorMensaje}': 'Condicion no puede ser null'};
    final PersonaDB db =
        new PersonaDB(await Dbase().database, '${Environment.tablaPersona}');

    return await db.obtenerPersonaPorLocalidad(idLocalidad);
  }
}
