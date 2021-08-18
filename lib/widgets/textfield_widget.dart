import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final double altoCampo;
  final double anchoCampo;
  final TextInputType textInputType;
  final int maxLength;
  final IconData iconoIzquierda;
  final IconData iconoDerecha;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final bool errorValidacion;
  final FocusNode fNode;
  final TextEditingController controller;

  const TextfieldWidget(
      {Key key,
      this.hintText,
      @required this.labelText,
      @required this.altoCampo,
      @required this.anchoCampo,
      this.textInputType = TextInputType.number,
      this.maxLength,
      this.iconoIzquierda,
      this.iconoDerecha,
      this.inputFormatters,
      this.controller,
      this.onChanged,
      this.errorValidacion = false,
      this.fNode})
      : super(key: key);

  @override
  _TextfieldWidgetState createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: this.widget.anchoCampo,
      constraints: BoxConstraints(
          maxHeight: this.widget.altoCampo, minHeight: this.widget.altoCampo),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          if (this.widget.errorValidacion)
            Positioned(
              top: this.widget.altoCampo * 3 / 100,
              right: this.widget.anchoCampo * 0.5 / 100,
              child: _IconoValidacion(
                  altoCampo: this.widget.altoCampo,
                  errorValidacion: this.widget.errorValidacion),
            ),
          Theme(
            child: TextField(
              controller: this.widget.controller,
              keyboardType: this.widget.textInputType,
              maxLength: this.widget.maxLength,
              inputFormatters: this.widget.inputFormatters,
              onChanged: this.widget.onChanged?.call,
              style: TextStyle(fontSize: this.widget.altoCampo * 30 / 100),
              focusNode: this.widget.fNode,
              decoration: _buildInputDecoration(size),
            ),
            data: Theme.of(context).copyWith(
              primaryColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(Size size) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _determinarColor(this.widget.errorValidacion))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _determinarColor(this.widget.errorValidacion),
                width: 2)),
        hintText: this.widget.hintText,
        labelText: this.widget.labelText,
        prefixIcon: this.widget.iconoIzquierda != null
            ? Icon(this.widget.iconoIzquierda,
                color: _determinarColor(this.widget.errorValidacion),
                size: this.widget.altoCampo * 40 / 100)
            : null,
        labelStyle: TextStyle(
            color: _determinarColor(this.widget.errorValidacion),
            fontSize: this.widget.altoCampo * 30 / 100),
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        errorStyle: TextStyle(fontSize: 0),

        ///Quita el contador de caracteres faltantes para el [maxLength]
        counterText: "");
  }

  Color _determinarColor(bool errorValidacion) {
    return errorValidacion ? Color(0xffD94D4D) : Color(0xff4081EC);
  }
}

class _IconoValidacion extends StatelessWidget {
  final bool errorValidacion;
  final double altoCampo;
  _IconoValidacion({this.errorValidacion, this.altoCampo});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cancel_outlined,
      size: this.altoCampo * 33 / 100,
      color: Color(0xffD94D4D),
    );
  }
}
