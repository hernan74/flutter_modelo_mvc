import 'package:flutter/material.dart';

import 'package:flutter_modelo_mvc/utils/size_scream_util.dart';

class DismissibleWidget extends StatefulWidget {
  final Widget contenido;
  final String tituloEliminar;
  final Function confirmacionEliminar;

  const DismissibleWidget(
      {@required this.contenido,
      this.tituloEliminar = 'Eliminar',
      @required this.confirmacionEliminar});

  @override
  _DismissibleWidgetState createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget>
    with TickerProviderStateMixin {
  double initial = 0.0;
  double moverHorizontal = 0.0;
  bool mostrarConfirmacionEliminar = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextStyle estiloTexto =
        TextStyle(color: Colors.white, fontSize: size.height * 2.4 / 100);
    return GestureDetector(
      onPanStart: (this.widget.confirmacionEliminar == null)
          ? null
          : (DragStartDetails details) {
              initial = details.globalPosition.dx;
            },
      onPanUpdate: (this.widget.confirmacionEliminar == null)
          ? null
          : (DragUpdateDetails details) {
              setState(() {
                moverHorizontal = sizeScreemUtil(
                    sizeActual: details.globalPosition.dx - initial,
                    sizeMin: 0,
                    sizeMax: size.width * 20 / 100);
              });
            },
      onPanEnd: (this.widget.confirmacionEliminar == null)
          ? null
          : (DragEndDetails details) {
              initial = 0.0;
              if (moverHorizontal < size.width * 20 / 100) {
                setState(() {
                  moverHorizontal = 0;
                  this.mostrarConfirmacionEliminar = false;
                });
              }
            },
      child: Container(
        width: size.width * 95 / 100,
        height: size.height * 11 / 100,
        child: Stack(
          children: <Widget>[
            Container(
              width: moverHorizontal,
              decoration: BoxDecoration(
                color: this.widget.confirmacionEliminar != null
                    ? Colors.red
                    : Colors.grey,
              ),
              margin: EdgeInsets.only(left: 0, bottom: size.height * 1 / 100),
              // height: size.height * 9.8 / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Icon(
                            Icons.delete,
                            size: moverHorizontal > size.width * 8 / 100
                                ? size.height * 3.5 / 100
                                : 0,
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (this.widget.confirmacionEliminar != null)
                              setState(() {
                                moverHorizontal = size.width * 45 / 100;
                                this.mostrarConfirmacionEliminar = true;
                              });
                          }),
                      if (this.mostrarConfirmacionEliminar)
                        Text(
                          this.widget.tituloEliminar,
                          style: estiloTexto,
                        ),
                    ],
                  ),
                  if (this.mostrarConfirmacionEliminar)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Spacer(),
                        GestureDetector(
                            child: Text(
                              'Si',
                              style: estiloTexto,
                            ),
                            onTap: () {
                              setState(() {
                                moverHorizontal = 0;
                                this.mostrarConfirmacionEliminar = false;
                              });
                              this.widget?.confirmacionEliminar();
                            }),
                        Spacer(),
                        GestureDetector(
                            child: Text(
                              'No',
                              style: estiloTexto,
                            ),
                            onTap: () {
                              setState(() {
                                moverHorizontal = 0;
                                this.mostrarConfirmacionEliminar = false;
                              });
                            }),
                        Spacer(),
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
              top: -size.height * 0.5 / 100,
              left: moverHorizontal,
              child: Container(
                width: size.width * 95 / 100,
                height: size.height * 10.5 / 100,
                child: this.widget.contenido,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
