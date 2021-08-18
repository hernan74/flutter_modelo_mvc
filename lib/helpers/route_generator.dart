import 'package:flutter/material.dart';

import 'package:flutter_modelo_mvc/pages/home_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      ///HOME_PAGE
      case 'home':
        return _fadeRoute(HomeView());

      ///RUTA_INEXISTENTE
      default:
        return _fadeRoute(Container());
    }
  }

  static PageRoute _fadeRoute(Widget child) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curveAnimation =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);

        return FadeTransition(
            opacity:
                Tween<double>(begin: 0.0, end: 1.0).animate(curveAnimation),
            child: child);
      },
    );
  }
}
