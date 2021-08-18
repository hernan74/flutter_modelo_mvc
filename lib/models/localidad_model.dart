import 'package:flutter/material.dart';
import 'package:flutter_modelo_mvc/models/itemlista_model.dart';

class LocalidadModel extends ItemListaModel {
  final int id;
  final String nombre;

  LocalidadModel({
    this.id,
    this.nombre,
  }) : super(codigo: id, descripcion: nombre);

  LocalidadModel copyWith({
    int id,
    String nombre,
  }) =>
      LocalidadModel(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
      };
  factory LocalidadModel.fromJson(Map<String, dynamic> json) =>
      LocalidadModel(id: json["Id"] ?? '', nombre: json["Nombre"] ?? '');

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
