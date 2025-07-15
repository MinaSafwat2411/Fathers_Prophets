import 'package:fathers_prophets/data/services/google_drive_service.dart';
import 'package:fathers_prophets/presentation/cubit/add_attendance/cubit/add_attendance_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/add_member/cubit/add_member_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/attendance/cubit/attendance_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/dashboard/cubit/dashboard_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/states/local_states.dart';
import 'package:fathers_prophets/presentation/cubit/login/cubit/login_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/onboarding/cubit/onboarding_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/pin/cubit/pin_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/profile/cubit/profile_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quiz_table/cubit/quiz_table_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/cubit/quizzes_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/register/cubit/register_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/review_user/cubit/review_user_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/splash/cubit/splash_cubit.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/utils/app_themes.dart';
import 'data/services/bloc_observer.dart';
import 'data/services/cache_helper.dart';
import 'data/services/notification_services.dart';
import 'data/firebase/firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  if (kDebugMode) Bloc.observer = MyBlocObserver();
  bool isDark = await CacheHelper.getData(key: 'isDark') ?? false;
  String lang = await CacheHelper.getData(key: 'lang') ?? 'en';
  String uid = await CacheHelper.getData(key: 'uid') ?? '';
  bool isOpened = CacheHelper.getData(key: 'isOpened') ?? false;
  runApp(MyApp(isDark: isDark, lang: lang, uid: uid, isOpened: isOpened));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.isDark,required this.lang,required this.uid,required this.isOpened});
  final bool isDark;
  final String lang;
  final String uid;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale(lang,isDark)),
          BlocProvider(create: (context) => SplashCubit()..onNavigate(isDark,uid,isOpened)),
          BlocProvider(create: (context) => OnboardingCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => LayoutCubit()..getUserData()..getAllData()..getAllAttendance(lang)),
          BlocProvider(create: (context) => AttendanceCubit()),
          BlocProvider(create: (context) => AddAttendanceCubit()..getUserData()),
          BlocProvider(create: (context) => QuizzesCubit(),),
          BlocProvider(create: (context) => ProfileCubit()..getUserData()),
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => CommentCubit()),
          BlocProvider(create: (context) => EventsCubit()..getAllMembers()),
          BlocProvider(create: (context) => DashboardCubit()..getAllData()),
          BlocProvider(create: (context) => ForgotPasswordCubit(),),
          BlocProvider(create: (context) => AddMemberCubit()..getData(),),
          BlocProvider(create: (context) => ReviewUserCubit()..getData(),),
          BlocProvider(create: (context) => PinCubit(),),
          BlocProvider(create: (context) => QuizTableCubit()..getAllQuizzesScore(),)
        ],
        child: BlocConsumer<LocaleCubit, LocaleStates>(
          builder: (context, state) => MaterialApp.router(
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            title: 'Fathers Prophets',
            locale: state.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ar', 'SA'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            builder: (context, child) {
              return Directionality(
                  textDirection: state.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child: child!
              );
            },
          ),
          listener: (context, state) {},
          buildWhen: (previous, current) => current is! LocaleInitial,
        )
    );
  }
}
