import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_books/core/routing/router.dart';
import 'package:my_books/core/routing/routes.dart';
import 'package:my_books/core/theme/app_theme.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/dependencies.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //
  const String baseUrl = 'http://openlibrary.org';
  const int defaultReceiveTimeout = 15000;
  const int defaultConnectTimeout = 15000;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<BookModel>(BookModelAdapter());

  final bookBox = await Hive.openBox<BookModel>('Book');

  Dio dioClient = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: defaultConnectTimeout,
    receiveTimeout: defaultReceiveTimeout,
  ));

  runApp(_MyApp(
    client: dioClient,
    bookBox: bookBox,
  ));
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key? key,
    required this.client,
    required this.bookBox,
  }) : super(key: key);

  final Dio client;
  final Box<BookModel> bookBox;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(
        client: client,
        bookBox: bookBox,
      ),
      child: MultiBlocProvider(
        providers: buildBlocs(context),
        child: MaterialApp(
          title: 'MyBooks',
          theme: AppTheme.themeLight,
          themeMode: ThemeMode.light,
          initialRoute: RoutePaths.principal,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
