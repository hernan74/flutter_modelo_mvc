import 'package:flutter/material.dart';

import 'package:flutter_modelo_mvc/models/itemlista_model.dart';

class ComboWidget extends StatefulWidget {
  final String titulo;
  final List<ItemListaModel> opciones;
  final ItemListaModel valorDefecto;
  final ValueChanged<ItemListaModel> onSeleccionoOpcion;

  const ComboWidget(
      {@required this.opciones,
      this.titulo,
      this.valorDefecto,
      this.onSeleccionoOpcion});

  @override
  _ComboWidgetState createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  ItemListaModel valorSeleccionado;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.valorSeleccionado = this.widget.valorDefecto;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.75 / 100),
      height: size.height * 6 / 100,
      width: size.width * 95 / 100,
      child: Stack(
        children: [
          DropdownButtonFormField<ItemListaModel>(
            icon: Icon(
              Icons.arrow_drop_down,
              size: size.height * 2.7 / 100,
              color: this.widget.opciones.isNotEmpty
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            decoration: InputDecoration(
              labelText: this.widget.titulo,
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: size.height * 2 / 100),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 2 / 100,
                  vertical: size.height * 1 / 100),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: this.widget.opciones.isNotEmpty
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
              ),
            ),
            value: this.valorSeleccionado,
            onChanged: (value) {
              setState(() {
                valorSeleccionado = value;
                this.widget.onSeleccionoOpcion?.call(value);
              });
            },
            items: this
                .widget
                .opciones
                .map<DropdownMenuItem<ItemListaModel>>(
                    (e) => DropdownMenuItem<ItemListaModel>(
                          child: Text(e.descripcion),
                          value: e,
                        ))
                .toList(),
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
