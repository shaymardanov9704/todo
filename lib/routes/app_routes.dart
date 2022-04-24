
import 'package:todo_task/routes/app_pages.dart';
import 'package:todo_task/ui/add_task/add_screen.dart';
import 'package:todo_task/ui/main/empty.dart';
import 'package:todo_task/ui/main/main_screen.dart';
import 'package:todo_task/ui/splash_screen/splash_screen.dart';
import 'package:todo_task/ui/tasks/task_open.dart';
import 'package:todo_task/ui/tasks/tasks_screen.dart';

class AppPages {
  static final page = {
    AppRoutes.splash: (context) =>const SplashScreen(),
    AppRoutes.main: (context) =>const MainScreen(),
    AppRoutes.empty:(context)=>const Empty(),
    AppRoutes.tasks:(context)=>const Tasks(),
    AppRoutes.taskOpen:(context)=>const TaskOpen(),
    AppRoutes.add:(context)=>const AddScreen()
  };
}
