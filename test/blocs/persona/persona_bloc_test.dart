import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_modelo_mvc/blocs/persona/persona_bloc.dart';
import 'package:flutter_modelo_mvc/data/personas/persona_data.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/persona_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PersonaDataMock extends Mock implements PersonaData {}

void main() {
  group('PersonaBloc test', () {
    PersonaBloc personaBloc;
    PersonaData personaDataMock;

    Map<String, dynamic> errorResp = {'${Environment.errorMensaje}': 'Error'};
    Map<String, dynamic> okResp = {'${Environment.datosOk}': 'Guardado'};

    Map<String, dynamic> listaPersonasMap = {
      '${Environment.datosOk}': [
        {'Id': 1, 'Nombre': 'Hernan'}
      ]
    };
    List<PersonaModel> listaPersonasModel = [
      new PersonaModel(id: 1, nombre: 'Hernan')
    ];
    setUp(() {
      personaDataMock = new PersonaDataMock();
      personaBloc = new PersonaBloc(personaDataMock);
    });

    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnInitializaPersona',
      build: () {
        return personaBloc;
      },
      act: (bloc) => bloc.add(OnInitializaPersona()),
      expect: () => [
        PersonaState().iniState(),
      ],
    );

    // 'Evento de OnObtieneListaPersona. Error al obtener datos',
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnObtieneListaPersona. Error al obtener datos',
      build: () {
        when(() => personaDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(errorResp));
        return personaBloc;
      },
      act: (bloc) => bloc.add(OnObtieneListaPersona()),
      expect: () => [
        PersonaState().copyWith(
            isWorking: true,
            lstPersonas: [],
            accion: '${Environment.lstPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            error: 'Error',
            lstPersonas: [],
            accion: '${Environment.lstPersona}'),
      ],
    );

    // Evento de OnObtieneListaPersona. Devuelve lista de resultados
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnObtieneListaPersona. Devuelve lista de resultados',
      build: () {
        when(() => personaDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaPersonasMap));
        return personaBloc;
      },
      act: (bloc) => bloc.add(OnObtieneListaPersona()),
      expect: () => [
        PersonaState().copyWith(
            isWorking: true,
            lstPersonas: [],
            accion: '${Environment.lstPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            lstPersonas: listaPersonasModel,
            accion: '${Environment.lstPersona}'),
      ],
    );

    // Evento de OnNuevaPersona. nombre en blanco
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnNuevaPersona. nombre en blanco',
      build: () {
        when(() => personaDataMock
                .guardar(new PersonaModel(nombre: null, edad: null)))
            .thenAnswer((_) async => Future.value(errorResp));
        when(() => personaDataMock
                .guardar(new PersonaModel(nombre: '', edad: null)))
            .thenAnswer((_) async => Future.value(errorResp));
        return personaBloc;
      },
      act: (bloc) => bloc
        ..add(OnGuardaPersona(new PersonaModel(nombre: null, edad: null)))
        ..add(OnGuardaPersona(new PersonaModel(nombre: '', edad: null))),
      expect: () => [
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.guardaPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            error: 'Error',
            accion: '${Environment.guardaPersona}'),
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.guardaPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            error: 'Error',
            accion: '${Environment.guardaPersona}'),
      ],
    );

    // Evento de OnGuardaPersona. Agrego
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnGuardaPersona. Agrego',
      build: () {
        when(() => personaDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaPersonasMap));
        when(() => personaDataMock
                .guardar(new PersonaModel(nombre: 'Hernan', edad: 27)))
            .thenAnswer((_) async => Future.value(okResp));
        return personaBloc;
      },
      act: (bloc) => bloc
          .add(OnGuardaPersona(new PersonaModel(nombre: 'Hernan', edad: 27))),
      expect: () => [
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.guardaPersona}'),
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.lstPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            lstPersonas: listaPersonasModel,
            accion: '${Environment.lstPersona}'),
      ],
    );
    // Evento de OnGuardaPersona. Modifico
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnGuardaPersona. Modifico',
      build: () {
        when(() => personaDataMock
                .modificar(new PersonaModel(id: 2, nombre: 'Hernan', edad: 27)))
            .thenAnswer((_) async => Future.value(okResp));
        when(() => personaDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaPersonasMap));
        return personaBloc;
      },
      act: (bloc) => bloc.add(
          OnGuardaPersona(new PersonaModel(id: 2, nombre: 'Hernan', edad: 27))),
      expect: () => [
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.guardaPersona}'),
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.lstPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            lstPersonas: listaPersonasModel,
            accion: '${Environment.lstPersona}'),
      ],
    );
    // 'Evento de OnEliminaPersona. Elimina
    blocTest<PersonaBloc, PersonaState>(
      'Evento de OnEliminaPersona. Elimina',
      build: () {
        when(() => personaDataMock.eliminar(1))
            .thenAnswer((_) async => Future.value(okResp));
        when(() => personaDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaPersonasMap));
        return personaBloc;
      },
      act: (bloc) => bloc.add(OnEliminaPersona(1)),
      expect: () => [
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.borrarPersona}'),
        PersonaState()
            .copyWith(isWorking: true, accion: '${Environment.lstPersona}'),
        PersonaState().copyWith(
            isWorking: false,
            lstPersonas: listaPersonasModel,
            accion: '${Environment.lstPersona}'),
      ],
    );
  });
}
