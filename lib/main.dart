import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/routes/app_pages.dart';

import 'models/task.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('task');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.light,
      darkTheme: AppThemes.dark,
      routes: AppPages.page,
      initialRoute: AppRoutes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
