import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/localidad/localidad_bloc.dart';
import 'package:flutter_modelo_mvc/blocs/persona/persona_bloc.dart';
import 'package:flutter_modelo_mvc/data/db/dbase.dart';

import 'package:flutter_modelo_mvc/data/localidades/localidad_data_impl.dart';
import 'package:flutter_modelo_mvc/data/personas/persona_data_impl.dart';
import 'package:flutter_modelo_mvc/helpers/route_generator.dart';
import 'package:flutter_modelo_mvc/pages/home_page.dart';
import 'package:flutter_modelo_mvc/services/navigaton_service.dart';
import 'package:flutter_modelo_mvc/widgets/error_dibujado_widget.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonaBloc>(
            create: (_) => PersonaBloc(PersonaDataImpl())),
        BlocProvider<LocalidadBloc>(
            create: (_) => LocalidadBloc(LocalidadDataImpl(Dbase().database))),
      ],
      child: MaterialApp(
        navigatorKey: navigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Ejemplo',
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: 'home',
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>
              ErrorDibujadoWidget(widget: widget);

          return MediaQuery(

              ///[textScaleFactor] Previene el escalado de los textos al cambiar el tamaño del texto en el dispositivo
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: HomePage(contenidoVentana: child));
        },
      ),
    );
  }
}
