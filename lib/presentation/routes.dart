import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/presentation/screens/add_attendance_screen/add_attendance_screen.dart';
import 'package:fathers_prophets/presentation/screens/attendance_details_screen/attendance_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/layout_screen/layout_screen.dart';
import 'package:fathers_prophets/presentation/screens/login_screen/login_screen.dart';
import 'package:fathers_prophets/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:fathers_prophets/presentation/screens/profile_screen/profile_screen.dart';
import 'package:fathers_prophets/presentation/screens/quizzes_details_screen/quizzes_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/setting_screen/setting_screen.dart';
import 'package:fathers_prophets/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/models/attendance/attendance_model.dart';
import 'cubit/attendance/cubit/attendance_cubit.dart';

enum AppRoutes {
  login,
  splash,
  layout,
  onboarding,
  search,
  profile,
  notifications,
  settings,
  help,
  about,
  contact,
  register,
  forgotPassword,
  resetPassword,
  bookingDetails,
  attendanceDetails,
  addAttendance,
  quizDetails,
  addQuiz,
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutePaths.splash, // Define initial route
  routes: [
    GoRoute(
      path: AppRoutePaths.login,
      name: AppRoutes.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.splash,
      name: AppRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.layout,
      name: AppRoutes.layout.name,
      builder: (context, state) => const LayoutScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      name: AppRoutes.onboarding.name,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.search,
      name: AppRoutes.search.name,
      builder: (context, state) => const Text('search'),
    ),
    GoRoute(
      path: AppRoutePaths.profile,
      name: AppRoutes.profile.name,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.notifications,
      name: AppRoutes.notifications.name,
      builder: (context, state) => const Text('notifications'),
    ),
    GoRoute(
      path: AppRoutePaths.settings,
      name: AppRoutes.settings.name,
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.help,
      name: AppRoutes.help.name,
      builder: (context, state) => const Text('help'),
    ),
    GoRoute(
      path: AppRoutePaths.about,
      name: AppRoutes.about.name,
      builder: (context, state) => const Text('about'),
    ),
    GoRoute(
      path: AppRoutePaths.contact,
      name: AppRoutes.contact.name,
      builder: (context, state) => const Text('contact'),
    ),
    GoRoute(
      path: AppRoutePaths.register,
      name: AppRoutes.register.name,
      builder: (context, state) => const Text('register'),
    ),
    GoRoute(
      path: AppRoutePaths.forgotPassword,
      name: AppRoutes.forgotPassword.name,
      builder: (context, state) => const Text('forgotPassword'),
    ),
    GoRoute(
      path: AppRoutePaths.resetPassword,
      name: AppRoutes.resetPassword.name,
      builder: (context, state) => const Text('resetPassword'),
    ),
    GoRoute(
      path: AppRoutePaths.bookingDetails,
      name: AppRoutes.bookingDetails.name,
      builder: (context, state) => const Text('bookingDetails'),
    ),
    GoRoute(
      path: AppRoutePaths.attendanceDetails,
      name: AppRoutes.attendanceDetails.name,
      builder:
          (context, state) => AttendanceDetailsScreen(
            attendance: state.extra as AttendanceModel,
          ),
      onExit: (context, state) {
        context.read<AttendanceCubit>().onRest();
        return true;
      },
    ),
    GoRoute(
      path: AppRoutePaths.addAttendance,
      name: AppRoutes.addAttendance.name,
      builder: (context, state) => const AddAttendanceScreen(),
      onExit: (context, state) {
        context.read<AttendanceCubit>().onRest();
        return true;
      },
    ),
    GoRoute(
      path: AppRoutePaths.quizDetails,
      name: AppRoutes.quizDetails.name,
      builder: (context, state) => QuizzesDetailsScreen(quizzes: state.extra as QuizzesModel,),
    ),
    GoRoute(
      path: AppRoutePaths.addQuiz,
      name: AppRoutes.addQuiz.name,
      builder: (context, state) => const Text('addQuiz'),
    ),
  ],
);

abstract class AppRoutePaths {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String splash = '/splash';
  static const String layout = '/layout';
  static const String onboarding = '/onboarding';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String help = '/help';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String bookingDetails = '/booking-details';
  static const String attendanceDetails = '/attendance-details';
  static const String addAttendance = '/add-attendance';
  static const String quizDetails = '/quiz-details';
  static const String addQuiz = '/add-quiz';
}
