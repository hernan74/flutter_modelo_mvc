import 'package:flutter/material.dart';

class ErrorDibujadoWidget extends StatelessWidget {
  final Widget widget;

  const ErrorDibujadoWidget({this.widget});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget error = SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
      Container(
          height: size.height * 16 / 100,
          child: Image.asset('assets/broken.png')),
      Text(
        'Oh no.. No se pudo cargar el elemento solicitado',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: size.height * 2.5 / 100),
      )
    ])));
    error = Container(
      height: size.height * 22 / 100,
      width: size.width * 80 / 100,
      child: Scaffold(body: error),
    );
    return error;
  }
}
