
import 'package:elenasorianoclases/presentation/screens/add_class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/add_student_screen.dart';
import 'package:elenasorianoclases/presentation/screens/add_student_to_class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/home_screen.dart';
import 'package:elenasorianoclases/presentation/screens/schedule_screen.dart';
import 'package:elenasorianoclases/presentation/screens/students_screen.dart';
import 'package:elenasorianoclases/presentation/screens/view_class_screen.dart';
import 'package:go_router/go_router.dart';


//final appRouter = GoRouter(initialLocation: '/verify-master-key', routes: [
final appRouter = GoRouter(initialLocation: '/home', routes: [

  GoRoute(
      path: '/add_student_class',
    name: AddStudentToClassScreen.name,
    builder: (context, state){
        return const AddStudentToClassScreen();
    }
  ),

  GoRoute(
      path: '/view_class',
    name: ViewClassScreen.name,
    builder: (context, state){
        return const ViewClassScreen();
    }
  ),

  GoRoute(
      path: '/add_class',
    name: AddClassScreen.name,
    builder: (context, state){
        return const AddClassScreen();
    }
  ),

  GoRoute(
      path: '/class',
    name: ClassScreen.name,
    builder: (context, state){
        return const ClassScreen();
    }
  ),

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