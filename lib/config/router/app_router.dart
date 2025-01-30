
import 'package:elenasorianoclases/presentation/screens/add_student_screen.dart';
import 'package:elenasorianoclases/presentation/screens/home_screen.dart';
import 'package:elenasorianoclases/presentation/screens/schedule_screen.dart';
import 'package:elenasorianoclases/presentation/screens/students_screen.dart';
import 'package:go_router/go_router.dart';


//final appRouter = GoRouter(initialLocation: '/verify-master-key', routes: [
final appRouter = GoRouter(initialLocation: '/home', routes: [

  /*
  GoRoute(
      path: path
  )*/

  GoRoute(
      path: '/add_student',
    name: AddStudentScreen.name,
    builder: (context, state){
        return const AddStudentScreen();
    }
  ),

  GoRoute(
      path: '/students',
    name: StudentsScreen.name,
    builder: (context, state){
        return const StudentsScreen();
    }
  ),

  GoRoute(
      path: '/schedule',
    name: ScheduleScreen.name,
    builder: (context, state){
        return const ScheduleScreen();
    }
  ),

  GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) {
        return HomeScreen();
      }
  ),

]);