
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/screens/add_class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/add_student_screen.dart';
import 'package:elenasorianoclases/presentation/screens/add_student_to_class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/class_screen.dart';
import 'package:elenasorianoclases/presentation/screens/home_screen.dart';
import 'package:elenasorianoclases/presentation/screens/login_screen.dart';
import 'package:elenasorianoclases/presentation/screens/not_allowed_screen.dart';
import 'package:elenasorianoclases/presentation/screens/profile_student_screen.dart';
import 'package:elenasorianoclases/presentation/screens/schedule_screen.dart';
import 'package:elenasorianoclases/presentation/screens/signup_screen.dart';
import 'package:elenasorianoclases/presentation/screens/students_screen.dart';
import 'package:elenasorianoclases/presentation/screens/view_class_screen.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(initialLocation: '/login_signup', routes: [
//final appRouter = GoRouter(initialLocation: '/not_allowed', routes: [

  GoRoute(
      path: '/not_allowed',
    name: NotAllowedScreen.name,
    builder: (context, state){
        return const NotAllowedScreen();
    }
  ),

  GoRoute(
      path: '/sign_up',
    name: SignupScreen.name,
    builder: (context, state){
        return const SignupScreen();
    }
  ),

  GoRoute(
      path: '/login_signup',
    name: LoginScreen.name,
    builder: (context, state){
        return const LoginScreen();
    }
  ),

  GoRoute(
    path: '/add_student_class',
    name: AddStudentToClassScreen.name,
    builder: (context, state) {
      return AddStudentToClassScreen(clase: state.extra as ClassModel);
    }
  ),

  GoRoute(
    path: '/profile_student',
    name: ProfileStudentScreen.name,
    builder: (context, state) {
      return ProfileStudentScreen(student: state.extra as StudentModel);
    },
  ),

  GoRoute(
      path: '/view_class',
    name: ViewClassScreen.name,
    builder: (context, state){
        return ViewClassScreen(clase: state.extra as ClassModel);
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