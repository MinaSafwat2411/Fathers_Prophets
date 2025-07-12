import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/screens/add_attendance_screen/add_attendance_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_event_attendance/add_event_attendance.dart';
import 'package:fathers_prophets/presentation/screens/add_event_screen/add_event_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_member_screen/add_member_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_quizzes_screen/add_quiz_screen.dart';
import 'package:fathers_prophets/presentation/screens/attendance_details_screen/attendance_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:fathers_prophets/presentation/screens/event_attendance_details_screen/event_attendance_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/event_details/event_details.dart';
import 'package:fathers_prophets/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:fathers_prophets/presentation/screens/layout_screen/layout_screen.dart';
import 'package:fathers_prophets/presentation/screens/login_screen/login_screen.dart';
import 'package:fathers_prophets/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:fathers_prophets/presentation/screens/pin_screen/pin_screen.dart';
import 'package:fathers_prophets/presentation/screens/profile_screen/profile_screen.dart';
import 'package:fathers_prophets/presentation/screens/quizzes_details_screen/quizzes_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/quizzes_score_table_screen/quizzes_score_table_screen.dart';
import 'package:fathers_prophets/presentation/screens/register_screen/register_screen.dart';
import 'package:fathers_prophets/presentation/screens/review_screen/review_screen.dart';
import 'package:fathers_prophets/presentation/screens/review_user_screen/review_user_screen.dart';
import 'package:fathers_prophets/presentation/screens/select_member_screen/select_member_screen.dart';
import 'package:fathers_prophets/presentation/screens/setting_screen/setting_screen.dart';
import 'package:fathers_prophets/presentation/screens/splash_screen/splash_screen.dart';
import 'package:fathers_prophets/presentation/screens/user_details_screen/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/attendance/attendance_model.dart';
import '../data/models/events/events_model.dart';

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
  addEvent,
  eventDetails,
  addEventAttendance,
  selectMember,
  dashBoard,
  userDetails,
  review,
  quizzesScoreTable,
  addMember,
  reviewUser,
  pin,
  eventAttendanceDetails
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
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.forgotPassword,
      name: AppRoutes.forgotPassword.name,
      builder: (context, state) => const ForgotPasswordScreen(),
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
    ),
    GoRoute(
      path: AppRoutePaths.addAttendance,
      name: AppRoutes.addAttendance.name,
      builder: (context, state) => const AddAttendanceScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.quizDetails,
      name: AppRoutes.quizDetails.name,
      builder: (context, state) => QuizzesDetailsScreen(quizzes: state.extra as QuizzesModel,query: state.uri.queryParameters,),
    ),
    GoRoute(
      path: AppRoutePaths.addQuiz,
      name: AppRoutes.addQuiz.name,
      builder: (context, state) => const AddQuizScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.addEvent,
      name: AppRoutes.addEvent.name,
      builder: (context, state) => const AddEventScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.eventDetails,
      name: AppRoutes.eventDetails.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return EventDetails(
          events: extra['items'] as List<EventsModel>,
          title: extra['title'] as String,
      );
      },
    ),
    GoRoute(
      path: AppRoutePaths.addEventAttendance,
      name: AppRoutes.addEventAttendance.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return AddEventAttendance(
          event: extra['item'] as EventsModel,
          title: extra['title'] as String,
      );
      },
    ),
    GoRoute(
      path: AppRoutePaths.selectMember,
      name: AppRoutes.selectMember.name,
      builder: (context, state) => const SelectMemberScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.dashBoard,
      name: AppRoutes.dashBoard.name,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.userDetails,
      name: AppRoutes.userDetails.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return UserDetailsScreen(
          uid: extra['uid'] as String,
          football: extra['football'] as int,
          volleyball: extra['volleyball'] as int,
          pingPong: extra['pingPong'] as int,
          chess: extra['chess'] as int,
          melodies: extra['melodies'] as int,
          choir: extra['choir'] as int,
          ritual: extra['ritual'] as int,
          coptic: extra['coptic'] as int,
          doctrine: extra['doctrine'] as int,
          bible: extra['bible'] as int,
          pray: extra['pray'] as int,
          praise: extra['praise'] as int,
        );
      },
    ),
    GoRoute(
      path: AppRoutePaths.review,
      name: AppRoutes.review.name,
      builder: (context, state) => const ReviewScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.quizzesScoreTable,
      name: AppRoutes.quizzesScoreTable.name,
      builder: (context, state) =>const QuizzesScoreTableScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.addMember,
      name: AppRoutes.addMember.name,
      builder: (context, state) => const AddMemberScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.reviewUser,
      name: AppRoutes.reviewUser.name,
      builder: (context, state) => ReviewUserScreen(
        user: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: AppRoutePaths.pin,
      name: AppRoutes.pin.name,
      builder: (context, state) => PinScreen(
        nextScreen: state.extra as String,
      ),
    ),
    GoRoute(
      path: AppRoutePaths.eventAttendanceDetails,
      name: AppRoutes.eventAttendanceDetails.name,
      builder: (context, state) => EventAttendanceDetailsScreen(
        members: state.extra as List<String>,
      )
    )
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
  static const String addEvent = '/add-event';
  static const String quizDetails = '/quiz-details';
  static const String addQuiz = '/add-quiz';
  static const String eventDetails = '/event-details';
  static const String addEventAttendance = '/add-event-attendance';
  static const String selectMember = '/select-member';
  static const String dashBoard = '/dashboard';
  static const String userDetails = '/user-details';
  static const String review = '/review_screen';
  static const String quizzesScoreTable = '/quizzes_score_table';
  static const String addMember = '/add_member';
  static const String reviewUser = '/review_user';
  static const String pin = '/pin';
  static const String eventAttendanceDetails = '/event_attendance_details';
}
