import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/onboarding/cubit/onboarding_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/profile/cubit/profile_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/splash/cubit/splash_cubit.dart';
import 'package:fathers_prophets/presentation/screens/add_attendance_screen/add_attendance_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_event_attendance/add_event_attendance.dart';
import 'package:fathers_prophets/presentation/screens/add_event_screen/add_event_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_member_screen/add_member_screen.dart';
import 'package:fathers_prophets/presentation/screens/add_quizzes_screen/add_quiz_screen.dart';
import 'package:fathers_prophets/presentation/screens/attendance_details_screen/attendance_details_screen.dart';
import 'package:fathers_prophets/presentation/screens/categories_screen/categories_screen.dart';
import 'package:fathers_prophets/presentation/screens/chat_bot_screen/chat_bot_screen.dart';
import 'package:fathers_prophets/presentation/screens/chat_servant_screen/chat_user_screen.dart';
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
import 'package:fathers_prophets/presentation/screens/setting_screen/setting_screen.dart';
import 'package:fathers_prophets/presentation/screens/splash_screen/splash_screen.dart';
import 'package:fathers_prophets/presentation/screens/user_details_screen/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../data/models/attendance/attendance_model.dart';
import '../data/models/events/events_model.dart';
import 'cubit/add_attendance/cubit/add_attendance_cubit.dart';
import 'cubit/add_member/cubit/add_member_cubit.dart';
import 'cubit/attendance/cubit/attendance_cubit.dart';
import 'cubit/chatbot/cubit/chatbot_cubit.dart';
import 'cubit/comment/cubit/comment_cubit.dart';
import 'cubit/dashboard/cubit/dashboard_cubit.dart';
import 'cubit/events/cubit/events_cubit.dart';
import 'cubit/forgot_password/cubit/forgot_password_cubit.dart';
import 'cubit/login/cubit/login_cubit.dart';
import 'cubit/pin/cubit/pin_cubit.dart';
import 'cubit/quiz_table/cubit/quiz_table_cubit.dart';
import 'cubit/quizzes/cubit/quizzes_cubit.dart';
import 'cubit/register/cubit/register_cubit.dart';
import 'cubit/review_user/cubit/review_user_cubit.dart';

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
  eventAttendanceDetails,
  categories,
  chatBot,
  chat,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: AppRoutePaths.splash,
  routes: [
    GoRoute(
      path: AppRoutePaths.login,
      name: AppRoutes.login.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.splash,
      name: AppRoutes.splash.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => SplashCubit()..onNavigate(),
            child: const SplashScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      name: AppRoutes.onboarding.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => OnboardingCubit(),
            child: const OnboardingScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.search,
      name: AppRoutes.search.name,
      builder: (context, state) => const Text('search'),
    ),
    GoRoute(
      path: AppRoutePaths.profile,
      name: AppRoutes.profile.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => ProfileCubit()..getUserData(),
            child: const ProfileScreen(),
          ),
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
      builder:
          (context, state) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.forgotPassword,
      name: AppRoutes.forgotPassword.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: const ForgotPasswordScreen(),
          ),
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
          (context, state) => BlocProvider(
            create: (context) => AttendanceCubit(),
            child: AttendanceDetailsScreen(
              attendance: state.extra as AttendanceModel,
            ),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.addAttendance,
      name: AppRoutes.addAttendance.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AddAttendanceCubit()..getUserData(),
            child: const AddAttendanceScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.quizDetails,
      name: AppRoutes.quizDetails.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final quiz = extra['quizzes'] as QuizzesModel;
        final query = state.uri.queryParameters;
        final quizzesCubit = extra['cubit'] as QuizzesCubit?;

        return BlocProvider<QuizzesCubit>(
          create: (_) => quizzesCubit ?? QuizzesCubit(),
          lazy: quizzesCubit == null,
          child: QuizzesDetailsScreen(quizzes: quiz, query: query),
        );
      },
    ),
    GoRoute(
      path: AppRoutePaths.addQuiz,
      name: AppRoutes.addQuiz.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => QuizzesCubit(),
            child: const AddQuizScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.addEvent,
      name: AppRoutes.addEvent.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => EventsCubit()..getAllMembers(),
            child: const AddEventScreen(),
          ),
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
      path: AppRoutePaths.selectMember,
      name: AppRoutes.selectMember.name,
      builder: (context, state) {
        return state.extra as Widget;
      },
    ),
    GoRoute(
      path: AppRoutePaths.dashBoard,
      name: AppRoutes.dashBoard.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => DashboardCubit()..getAllData(),
            child: const DashboardScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.userDetails,
      name: AppRoutes.userDetails.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return BlocProvider(
          create: (context) => CommentCubit(),
          child: UserDetailsScreen(
            uid: extra['uid'] as String,
          ),
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
      builder:
          (context, state) => BlocProvider(
            create: (context) => QuizTableCubit()..getAllQuizzesScore(),
            child: const QuizzesScoreTableScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.addMember,
      name: AppRoutes.addMember.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AddMemberCubit()..getData(),
            child: const AddMemberScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.reviewUser,
      name: AppRoutes.reviewUser.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => ReviewUserCubit()..getData(),
            child: ReviewUserScreen(user: state.extra as UserModel),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.pin,
      name: AppRoutes.pin.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => PinCubit(),
            child: PinScreen(nextScreen: state.extra as String),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.eventAttendanceDetails,
      name: AppRoutes.eventAttendanceDetails.name,
      builder:
          (context, state) => EventAttendanceDetailsScreen(
            members: state.extra as List<String>,
          ),
    ),
    GoRoute(
      path: AppRoutePaths.addEventAttendance,
      name: AppRoutes.addEventAttendance.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MaterialPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => EventsCubit()..getAllMembers(),
            child: AddEventAttendance(
              event: extra['item'] as EventsModel,
              title: extra['title'] as String,
            ),
          ),
        );
      },
    ),
    ShellRoute(
      navigatorKey: _rootNavigatorKey,
      builder: (context, state, child) {
        return BlocProvider(
          create:
              (_) =>
                  LayoutCubit()
                    ..getUserData()
                    ..getAllData()
                    ..getAllAttendance(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutePaths.layout,
          name: AppRoutes.layout.name,
          pageBuilder:
              (context, state) =>
                  MaterialPage(key: state.pageKey, child: const LayoutScreen()),
        ),
        GoRoute(
          path: AppRoutePaths.categories,
          name: AppRoutes.categories.name,
          pageBuilder:
              (context, state) => MaterialPage(
                key: state.pageKey,
                child: const CategoriesScreen(),
              ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutePaths.chatBot,
      name: AppRoutes.chatBot.name,
      builder:
          (context, state) => BlocProvider(
            create: (context) => ChatbotCubit(),
            child: const ChatBotScreen(),
          ),
    ),
    GoRoute(
      path: AppRoutePaths.chat,
      name: AppRoutes.chat.name,
      builder:
          (context, state) =>
              ChatUserScreen(receiverUserData: state.extra as ClassUserModel),
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
  static const String categories = '/categories';
  static const String chatBot = '/chat_bot';
  static const String chat = '/chat';
}
