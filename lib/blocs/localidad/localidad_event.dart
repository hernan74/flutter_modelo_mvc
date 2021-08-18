part of 'localidad_bloc.dart';

abstract class LocalidadEvent {}

class OnInitializaLocalidad extends LocalidadEvent {
  OnInitializaLocalidad();
}

class OnObtieneLocalidad extends LocalidadEvent {
  OnObtieneLocalidad();
}

class OnNuevaLocalidad extends LocalidadEvent {
  final String nombre;
  OnNuevaLocalidad(this.nombre);
}
