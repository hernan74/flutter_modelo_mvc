import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modelo_mvc/data/localidades/localidad_data.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/localidad_model.dart';

part 'localidad_event.dart';
part 'localidad_state.dart';

class LocalidadBloc extends Bloc<LocalidadEvent, LocalidadState> {
  LocalidadBloc(this.db) : super(LocalidadState().iniState());
  final LocalidadData db;
  @override
  Stream<LocalidadState> mapEventToState(
    LocalidadEvent event,
  ) async* {
    if (event is OnInitializaLocalidad) {
      yield state.iniState();
    } else if (event is OnObtieneLocalidad) {
      yield* _onObtieneLocalidad(event);
    } else if (event is OnNuevaLocalidad) {
      yield* _onNuevaLocalidad(event);
    }
  }

  Stream<LocalidadState> _onObtieneLocalidad(OnObtieneLocalidad event) async* {
    yield state.copyWith(isWorking: true, lstLocalidades: []);
    Map<String, dynamic> resp = await db.obtenerTodos();
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          error: resp != null
              ? resp['${Environment.errorMensaje}']
              : 'No se pudo obtener el listado de registro',
          lstLocalidades: []);
    } else {
      List<Map<String, Object>> lista = resp['${Environment.datosOk}'];
      List<LocalidadModel> res =
          lista.map((e) => LocalidadModel.fromJson(e)).toList();
      yield state.copyWith(isWorking: false, lstLocalidades: res);
    }
  }

  Stream<LocalidadState> _onNuevaLocalidad(OnNuevaLocalidad event) async* {
    yield state.copyWith(isWorking: true, error: '');
    if (event.nombre == null || event.nombre.isEmpty) {
      yield state.copyWith(isWorking: false, error: 'Ingrese un nombre');
      return;
    }

    LocalidadModel nuevo = new LocalidadModel(nombre: event.nombre);
    Map<String, dynamic> resp = await db.guardar(nuevo);
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          error: resp != null
              ? resp['${Environment.errorMensaje}']
              : 'No se pudo guardar el registro',
          lstLocalidades: []);
    } else {
      add(OnObtieneLocalidad());
    }
  }
}
