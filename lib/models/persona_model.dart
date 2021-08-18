import 'package:flutter/material.dart';

import 'package:flutter_modelo_mvc/models/itemlista_model.dart';

class PersonaModel extends ItemListaModel {
  final int id;
  final int idLocalidad;
  final String nombre;
  final int edad;

  PersonaModel({
    this.id,
    this.idLocalidad,
    this.nombre = '',
    this.edad,
  }) : super(codigo: id, descripcion: nombre);

  PersonaModel copyWith({
    int id,
    int idLocalidad,
    String nombre = '',
    int edad,
  }) =>
      PersonaModel(
        id: id ?? this.id,
        idLocalidad: idLocalidad ?? this.idLocalidad,
        nombre: nombre ?? this.nombre,
        edad: edad ?? this.edad,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IdLocalidad": idLocalidad,
        "Nombre": nombre,
        "Edad": edad,
      };

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        id: json["Id"] ?? '',
        idLocalidad: json["IdLocalidad"] != null ? json["IdLocalidad"] : null,
        nombre: json["Nombre"] ?? '',
        edad: json["Edad"] != null ? int.tryParse(json["Edad"]) : null,
      );

  @override
  String toString() {
    return this.descripcion ?? '';
  }

  @override
  bool operator ==(Object other) =>
      other is ItemListaModel &&
      other.codigo == codigo &&
      other.descripcion == descripcion;

  @override
  int get hashCode => hashValues(this.codigo, this.descripcion);
}
