import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/localidad/localidad_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/persona/persona_bloc.dart';

class HomePage extends StatefulWidget {
  final Widget contenidoVentana;

  const HomePage({@required this.contenidoVentana});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<LocalidadBloc>().add(OnObtieneLocalidad());
    context.read<PersonaBloc>().add(OnObtieneListaPersona());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<PersonaBloc, PersonaState>(
          listener: (context, statePersona) {
            if (statePersona.error.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(statePersona.error),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: BlocListener<LocalidadBloc, LocalidadState>(
            listener: (context, stateLocalidad) {
              if (stateLocalidad.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(stateLocalidad.error),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            child: SafeArea(child: widget.contenidoVentana),
          ),
        ));
  }
}
