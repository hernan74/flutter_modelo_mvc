import 'package:flutter/material.dart';

//Esta clase se va a utilizar para mantener un estandar en los anchos que se utilizara para el desarrollo de los sistemas

double sizeScreemUtil(
    {@required double sizeActual,
    @required double sizeMin,
    @required double sizeMax}) {
  if (sizeActual < sizeMax && sizeActual > sizeMin) return sizeActual;

  if (sizeActual < sizeMin)
    return sizeMin;
  else if (sizeActual > sizeMax)
    return sizeMax;
  else
    return sizeActual;
}
