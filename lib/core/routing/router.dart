import 'package:flutter/material.dart';
import 'package:my_books/core/routing/routes.dart';
import 'package:my_books/presentation/book_detail/view/book_detail_view.dart';
import 'package:my_books/presentation/navigator/navigator.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.bookDetail:
        return MaterialPageRoute(
          builder: (_) => const BookDetailView(),
        );
      case RoutePaths.login:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('bookList'),
            ),
          ),
        );
      case RoutePaths.principal:
        return MaterialPageRoute(
          builder: (_) => const NavigatorBottom(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
