import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_modelo_mvc/blocs/localidad/localidad_bloc.dart';
import 'package:flutter_modelo_mvc/data/localidades/localidad_data.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/localidad_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocalidadDataMock extends Mock implements LocalidadData {}

void main() {
  group('LocalidadBloc test', () {
    LocalidadBloc localidadBloc;
    LocalidadData localidadDataMock;

    Map<String, dynamic> errorResp = {'${Environment.errorMensaje}': 'Error'};
    Map<String, dynamic> okResp = {'${Environment.datosOk}': 'Guardado'};

    Map<String, dynamic> listaLocalidadesMap = {
      '${Environment.datosOk}': [
        {'Id': 1, 'Nombre': 'Eldorado'}
      ]
    };
    List<LocalidadModel> listaLocalidadesModel = [
      new LocalidadModel(id: 1, nombre: 'Eldorado')
    ];
    setUp(() {
      localidadDataMock = new LocalidadDataMock();
      localidadBloc = new LocalidadBloc(localidadDataMock);
    });

    blocTest<LocalidadBloc, LocalidadState>(
      'Evento de OnInitializaLocalidad',
      build: () {
        return localidadBloc;
      },
      act: (bloc) => bloc.add(OnInitializaLocalidad()),
      expect: () => [
        LocalidadState().iniState(),
      ],
    );
    // 'Evento de OnObtieneLocalidad. Error al obtener datos',
    blocTest<LocalidadBloc, LocalidadState>(
      'Evento de OnObtieneLocalidad. Error al obtener datos',
      build: () {
        when(() => localidadDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(errorResp));
        return localidadBloc;
      },
      act: (bloc) => bloc.add(OnObtieneLocalidad()),
      expect: () => [
        LocalidadState().copyWith(isWorking: true, lstLocalidades: []),
        LocalidadState()
            .copyWith(isWorking: false, error: 'Error', lstLocalidades: []),
      ],
    );
    // Evento de OnObtieneLocalidad. Devuelve lista de resultados
    blocTest<LocalidadBloc, LocalidadState>(
      'Evento de OnObtieneLocalidad. Devuelve lista de resultados',
      build: () {
        when(() => localidadDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaLocalidadesMap));
        return localidadBloc;
      },
      act: (bloc) => bloc.add(OnObtieneLocalidad()),
      expect: () => [
        LocalidadState().copyWith(isWorking: true, lstLocalidades: []),
        LocalidadState()
            .copyWith(isWorking: false, lstLocalidades: listaLocalidadesModel),
      ],
    );

    // Evento de OnNuevaLocalidad. nombre en blanco
    blocTest<LocalidadBloc, LocalidadState>(
      'Evento de OnNuevaLocalidad. nombre en blanco',
      build: () {
        return localidadBloc;
      },
      act: (bloc) =>
          bloc..add(OnNuevaLocalidad(null))..add(OnNuevaLocalidad('')),
      expect: () => [
        LocalidadState().copyWith(isWorking: true),
        LocalidadState().copyWith(isWorking: false, error: 'Ingrese un nombre'),
        LocalidadState().copyWith(isWorking: true),
        LocalidadState().copyWith(isWorking: false, error: 'Ingrese un nombre'),
      ],
    );

    // Evento de OnNuevaLocalidad. Guarda de forma correcta
    blocTest<LocalidadBloc, LocalidadState>(
      'Evento de OnNuevaLocalidad. nombre en blanco',
      build: () {
        when(() => localidadDataMock.obtenerTodos())
            .thenAnswer((_) async => Future.value(listaLocalidadesMap));
        when(() => localidadDataMock
                .guardar(new LocalidadModel(nombre: 'Eldorado')))
            .thenAnswer((_) async => Future.value(okResp));
        return localidadBloc;
      },
      act: (bloc) => bloc.add(OnNuevaLocalidad('Eldorado')),
      expect: () => [
        LocalidadState().copyWith(isWorking: true),
        LocalidadState()
            .copyWith(isWorking: false, lstLocalidades: listaLocalidadesModel),
      ],
    );
  });
}
