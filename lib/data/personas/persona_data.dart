import 'package:flutter_modelo_mvc/data/db/crud_model_data.dart';
import 'package:flutter_modelo_mvc/models/persona_model.dart';

abstract class PersonaData extends CrudModelData<PersonaModel> {
  Future<Map<String, dynamic>> obtenerPersonaPorLocalidad(int idLocalidad);
}
