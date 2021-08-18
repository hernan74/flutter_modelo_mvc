import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modelo_mvc/data/personas/persona_data.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/persona_model.dart';

part 'persona_event.dart';
part 'persona_state.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {
  PersonaBloc(this.db) : super(PersonaState().iniState());

  final PersonaData db;
  @override
  Stream<PersonaState> mapEventToState(
    PersonaEvent event,
  ) async* {
    if (event is OnInitializaPersona) {
      yield state.iniState();
    } else if (event is OnObtieneListaPersona) {
      yield* _onObtieneListaPersona(event);
    } else if (event is OnGuardaPersona) {
      yield* _onGuardaPersona(event);
    } else if (event is OnObtienePersona) {
      yield* _onObtienePersona(event);
    } else if (event is OnEliminaPersona) {
      yield* _onEliminaPersona(event);
    }
  }

  Stream<PersonaState> _onObtieneListaPersona(
      OnObtieneListaPersona event) async* {
    yield state.copyWith(isWorking: true, accion: '${Environment.lstPersona}');
    Map<String, dynamic> resp = await db.obtenerTodos();
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          lstPersonas: [],
          error: resp != null
              ? resp['${Environment.errorMensaje}']
              : 'No se pudo obtener el listado de registro',
          accion: '${Environment.lstPersona}',
          campoError: '');
    } else {
      List<Map<String, Object>> lista = resp['${Environment.datosOk}'];

      List<PersonaModel> res =
          lista.map((e) => PersonaModel.fromJson(e)).toList();
      yield state.copyWith(
          isWorking: false,
          lstPersonas: res,
          error: '',
          seleccion: new PersonaModel(),
          accion: '${Environment.lstPersona}',
          campoError: '');
    }
  }

  Stream<PersonaState> _onGuardaPersona(OnGuardaPersona event) async* {
    yield state.copyWith(
        isWorking: true, accion: '${Environment.guardaPersona}', error: '');
    Map<String, dynamic> resp;
    if (event.persona.id == null) {
      resp = await db.guardar(event.persona);
    } else {
      resp = await db.modificar(event.persona);
    }
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          error: resp != null
              ? resp['${Environment.errorMensaje}']
              : 'No se pudo guardar el registro',
          accion: '${Environment.guardaPersona}',
          seleccion: null,
          campoError: '');
    } else {
      add(OnObtieneListaPersona());
    }
  }

  Stream<PersonaState> _onObtienePersona(OnObtienePersona event) async* {
    yield state.copyWith(
        isWorking: true, accion: '${Environment.obtienePersona}');
    if (event.idPersona == null) {
      yield state.copyWith(
          isWorking: false,
          accion: '${Environment.obtienePersona}',
          error: 'Id de persona nula',
          seleccion: null);
      return;
    }
    Map<String, dynamic> resp = await db.buscarById(event.idPersona);
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          accion: '${Environment.obtienePersona}',
          error: resp['${Environment.errorMensaje}'],
          seleccion: null);
      return;
    }
    PersonaModel seleccion =
        PersonaModel.fromJson(resp['${Environment.datosOk}']);
    yield state.copyWith(
        isWorking: false,
        accion: '${Environment.obtienePersona}',
        error: '',
        seleccion: seleccion);
  }

  Stream<PersonaState> _onEliminaPersona(OnEliminaPersona event) async* {
    yield state.copyWith(
        isWorking: true, accion: '${Environment.borrarPersona}', error: '');
    if (event.idPersona == null || event.idPersona < 0) {
      yield state.copyWith(
          isWorking: false,
          accion: '${Environment.borrarPersona}',
          error: 'Id usuario invalido');
      return;
    }

    Map<String, dynamic> resp = await db.eliminar(event.idPersona);
    if (resp == null || resp.containsKey('${Environment.errorMensaje}')) {
      yield state.copyWith(
          isWorking: false,
          error: resp != null
              ? resp['${Environment.errorMensaje}']
              : 'No se borrar el registro',
          accion: '${Environment.borrarPersona}',
          seleccion: null,
          campoError: '');
    } else {
      add(OnObtieneListaPersona());
    }
  }
}
