part of 'persona_bloc.dart';

@immutable
abstract class PersonaEvent {}

class OnInitializaPersona extends PersonaEvent {
  OnInitializaPersona();
}

class OnGuardaPersona extends PersonaEvent {
  final PersonaModel persona;
  OnGuardaPersona(this.persona);
}

class OnObtienePersona extends PersonaEvent {
  final int idPersona;
  OnObtienePersona(this.idPersona);
}

class OnObtieneListaPersona extends PersonaEvent {
  OnObtieneListaPersona();
}

class OnModificaPersona extends PersonaEvent {
  final int idPersona;
  OnModificaPersona(this.idPersona);
}

class OnEliminaPersona extends PersonaEvent {
  final int idPersona;
  OnEliminaPersona(this.idPersona);
}

class OnListaPersonas extends PersonaEvent {
  OnListaPersonas();
}
