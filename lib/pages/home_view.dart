import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/localidad/localidad_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/persona/persona_bloc.dart';
import 'package:flutter_modelo_mvc/global/environment.dart';
import 'package:flutter_modelo_mvc/models/itemlista_model.dart';
import 'package:flutter_modelo_mvc/models/persona_model.dart';

import 'package:flutter_modelo_mvc/widgets/button_widget.dart';
import 'package:flutter_modelo_mvc/widgets/combo_widget.dart';
import 'package:flutter_modelo_mvc/widgets/dismissible_widget.dart';
import 'package:flutter_modelo_mvc/widgets/textfield_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 2 / 100),
        _FormularioLocalidad(),
        Divider(),
        _FormularioPersona(),
        BlocBuilder<PersonaBloc, PersonaState>(
          builder: (context, state) {
            return Expanded(
                child: state.lstPersonas.isEmpty
                    ? Center(child: Text('Sin registros'))
                    : ListView.builder(
                        itemCount: state.lstPersonas.length,
                        itemBuilder: (context, index) => DismissibleWidget(
                          confirmacionEliminar: () {
                            context.read<PersonaBloc>().add(
                                OnEliminaPersona(state.lstPersonas[index].id));
                          },
                          tituloEliminar: 'Borrar Registro?',
                          contenido: InkWell(
                            onTap: () => context.read<PersonaBloc>().add(
                                OnObtienePersona(state.lstPersonas[index].id)),
                            child: ListTile(
                              title: Text(state.lstPersonas[index].nombre),
                              subtitle: Text(
                                  '${state.lstPersonas[index]?.edad ?? ''}'),
                            ),
                          ),
                        ),
                      ));
          },
        )
      ],
    );
  }
}

class _FormularioPersona extends StatefulWidget {
  @override
  __FormularioPersonaState createState() => __FormularioPersonaState();
}

class __FormularioPersonaState extends State<_FormularioPersona> {
  int idPersona;
  final TextEditingController nombreController = new TextEditingController();
  final TextEditingController edadController = new TextEditingController();
  ItemListaModel localidad;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<PersonaBloc, PersonaState>(
      listenWhen: (previous, current) =>
          !current.isWorking &&
          (current.accion == '${Environment.lstPersona}' ||
              current.accion == '${Environment.obtienePersona}'),
      listener: (context, state) {
        idPersona = state.seleccion.id;
        nombreController.text = state.seleccion?.nombre ?? '';
        edadController.text = state.seleccion?.edad?.toString() ?? '';
        localidad = null;
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextfieldWidget(
              controller: this.nombreController,
              labelText: 'Nombre',
              textInputType: TextInputType.text,
              altoCampo: size.height * 6 / 100,
              anchoCampo: size.width * 95 / 100),
          SizedBox(height: size.height * 2 / 100),
          TextfieldWidget(
              controller: this.edadController,
              labelText: 'Edad',
              altoCampo: size.height * 6 / 100,
              anchoCampo: size.width * 95 / 100),
          SizedBox(height: size.height * 2 / 100),
          BlocBuilder<LocalidadBloc, LocalidadState>(
            builder: (context, state) {
              return ComboWidget(
                opciones: state.lstLocalidades,
                titulo: 'Localidades',
                valorDefecto: localidad,
                onSeleccionoOpcion: (value) => localidad = value,
              );
            },
          ),
          ButtonWidget(
            texto: 'Agregar',
            altoMaximo: size.height * 5 / 100,
            onPressed: () {
              final PersonaModel personaModel = new PersonaModel(
                  id: idPersona,
                  nombre: this.nombreController.text,
                  edad: int.tryParse(
                    this.edadController.text,
                  ),
                  idLocalidad: localidad != null ? localidad.codigo : null);
              context.read<PersonaBloc>().add(OnGuardaPersona(personaModel));
            },
          ),
        ],
      ),
    );
  }
}

class _FormularioLocalidad extends StatefulWidget {
  @override
  __FormularioLocalidadState createState() => __FormularioLocalidadState();
}

class __FormularioLocalidadState extends State<_FormularioLocalidad> {
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LocalidadBloc, LocalidadState>(
      listener: (context, state) {
        controller.text = '';
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextfieldWidget(
            textInputType: TextInputType.text,
            labelText: 'Localidad',
            hintText: 'Nombre nueva localidad',
            altoCampo: size.height * 6 / 100,
            anchoCampo: size.width * 95 / 100,
            controller: this.controller,
          ),
          SizedBox(height: size.height * 2 / 100),
          ButtonWidget(
            texto: 'Agregar',
            altoMaximo: size.height * 5 / 100,
            onPressed: () {
              context
                  .read<LocalidadBloc>()
                  .add(OnNuevaLocalidad(this.controller.text));
            },
          ),
          SizedBox(height: size.height * 2 / 100),
        ],
      ),
    );
  }
}
