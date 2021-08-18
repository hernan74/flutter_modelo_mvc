part of 'localidad_bloc.dart';

class LocalidadState extends Equatable {
  final bool isWorking;
  final String error;
  final List<LocalidadModel> lstLocalidades;

  LocalidadState({
    this.isWorking = false,
    this.error = '',
    List<LocalidadModel> lstLocalidades,
  }) : this.lstLocalidades = lstLocalidades ?? [];

  LocalidadState copyWith(
          {bool isWorking,
          String error,
          List<LocalidadModel> lstLocalidades}) =>
      LocalidadState(
          isWorking: isWorking ?? this.isWorking,
          error: error ?? this.error,
          lstLocalidades: lstLocalidades ?? this.lstLocalidades);

  LocalidadState iniState() => new LocalidadState();
  @override
  List<Object> get props => [isWorking, error, lstLocalidades];
}
