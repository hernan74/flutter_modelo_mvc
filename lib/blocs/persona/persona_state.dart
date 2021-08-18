part of 'persona_bloc.dart';

@immutable
class PersonaState extends Equatable {
  final bool isWorking;
  final String accion;
  final List<PersonaModel> lstPersonas;
  final PersonaModel seleccion;
  final String campoError;
  final String error;

  PersonaState(
      {this.isWorking = false,
      this.accion = '',
      this.campoError = '',
      this.error = '',
      List<PersonaModel> lstPersonas,
      PersonaModel seleccion})
      : this.lstPersonas = lstPersonas ?? [],
        this.seleccion = seleccion ?? new PersonaModel();

  PersonaState copyWith({
    bool isWorking,
    String accion,
    List<PersonaModel> lstPersonas,
    PersonaModel seleccion,
    String campoError,
    String error,
  }) =>
      new PersonaState(
        isWorking: isWorking ?? this.isWorking,
        accion: accion ?? this.accion,
        lstPersonas: lstPersonas ?? this.lstPersonas,
        seleccion: seleccion ?? this.seleccion,
        campoError: campoError ?? this.campoError,
        error: error ?? this.error,
      );

  PersonaState iniState() => new PersonaState();

  @override
  List<Object> get props =>
      [isWorking, accion, lstPersonas, seleccion, campoError, error];
}
