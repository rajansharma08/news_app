// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/article.dart';
import 'providers/news_provider.dart';
import 'screens/headlines_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>('articles');

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider()..fetchHeadlines(),
      child: MaterialApp(
        title: 'DTown News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF464646),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF464646),
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
        ),
        home: const HeadlinesScreen(),
      ),
    );
  }
}