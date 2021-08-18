import 'dart:io';

import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Dbase {
  static Database _database;
  static final Dbase _db = new Dbase._();

  Dbase._();

  factory Dbase() {
    return _db;
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await iniDB();
    return _database;
  }

  Future<Database> iniDB() async {
    //Path donde esta la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, Environment.dbase);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE ${Environment.tablaPersona}(
            Id INTEGER,
            IdLocalidad INTEGER,
            Nombre TEXT,
            Edad TEXT,
            PRIMARY KEY(Id)
          )
      ''');
      await db.execute('''
          CREATE TABLE ${Environment.tablaLocalidad}(
            Id INTEGER,
            Nombre TEXT,
            PRIMARY KEY(Id)
          )
      ''');
    });
  }
}
