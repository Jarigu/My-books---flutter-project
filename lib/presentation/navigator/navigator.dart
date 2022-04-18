import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/presentation/books/view/books_view.dart';
import 'package:my_books/presentation/favorite_books/cubit/favorite_books_cubit.dart';
import 'package:my_books/presentation/favorite_books/view/favorite_books_view.dart';

class NavigatorBottom extends StatefulWidget {
  const NavigatorBottom({Key? key}) : super(key: key);

  @override
  State<NavigatorBottom> createState() => _NavigatorBottomState();
}

class _NavigatorBottomState extends State<NavigatorBottom> {
  int _navIndex = 0;

  late final List<Widget> views;
  @override
  void initState() {
    super.initState();

    views = List<Widget>.unmodifiable([
      const BooksView(),
      const FavoriteBooksView(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white54,
          body: IndexedStack(
            index: _navIndex,
            children: views,
          ),
          bottomNavigationBar: _BottomNavigationBar(
            activeIndex: _navIndex,
            onPressed: (i) {
              if (i == 1) {
                context.read<FavoriteBooksCubit>().getFavoriteBooks();
              }
              setState(() => _navIndex = i);
            },
          ),
        ),
        onWillPop: () async {
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        },
      );
    });
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar(
      {required this.onPressed, required this.activeIndex})
      : super();
  final Function(int) onPressed;
  final int activeIndex;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Books',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      currentIndex: widget.activeIndex,
      selectedItemColor: Colors.amber[800],
      onTap: widget.onPressed,
    );
  }
}
