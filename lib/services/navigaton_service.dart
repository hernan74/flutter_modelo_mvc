import 'package:flutter/material.dart';

///Clase que almacena el global key de la navegacion.
///Tambien posee las acciones para navegar a otra vista y cerrar.
class _NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future navigateTo({String routeName, Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future navigateRemplaceTo({String route, Object arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  ///Cierra todas las ventanas que tenga el navigator y deja unicamente a la nueva que se va a dirigir
  Future pushNamedAndRemoveUntil({String route, Object arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}

final navigationService = new _NavigationService();
