import 'package:flutter_modelo_mvc/data/localidades/localidad_data_impl.dart';
import 'package:flutter_modelo_mvc/data/localidades/localidad_db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

///TODO ver despues como hacer test de esto
class DatabaseMock extends Mock implements Database {}

class LocalidadDataImplMock extends Mock implements LocalidadDataImpl {}

class LocalidadDBMock extends Mock implements LocalidadDB {}

void main() {
  group('LocalidadDataImpl test', () {
    LocalidadDataImpl localidadDataImpl;
    Future<Database> databaseMock;
    LocalidadDBMock localidadDBMock;
    setUp(() {
      localidadDBMock = new LocalidadDBMock();
      databaseMock = Future.value(new DatabaseMock());
      localidadDataImpl = new LocalidadDataImpl(databaseMock);
    });

    test('a', () async {
      Map<String, dynamic> resp;

      when(() => localidadDBMock.buscarById(where: 'Id=', whereArgs: [1]))
          .thenAnswer((_) async {
        resp = {'true': 'true'};
        print('resp $resp');
        return resp;
      });
    });
  });
}
