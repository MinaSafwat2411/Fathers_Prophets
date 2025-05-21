import 'package:fathers_prophets/presentation/cubit/attendance/cubit/attendance_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/profile/cubit/profile_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/cubit/quizzes_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/states/local_states.dart';
import 'package:fathers_prophets/presentation/cubit/login/cubit/login_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/onboarding/cubit/onboarding_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/register/cubit/register_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/splash/cubit/splash_cubit.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/localization/app_localizations.dart';
import 'core/utils/app_themes.dart';
import 'data/firebase/firebase_options.dart';
import 'data/services/bloc_observer.dart';
import 'data/services/cache_helper.dart';
import 'data/services/notification_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.init();
  await NotificationService.handleFirebaseMessaging();
  if(kDebugMode) Bloc.observer = MyBlocObserver();
  bool isDark = await CacheHelper.getData(key: 'isDark') ?? false;
  String lang = await CacheHelper.getData(key: 'lang') ?? 'en';
  String uid = await CacheHelper.getData(key: 'uid') ?? '';
  bool isOpened = CacheHelper.getData(key: 'isOpened') ?? false;
  runApp(MyApp(isDark: isDark,lang: lang,uid: uid,isOpened: isOpened));
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
          BlocProvider(create: (context) => LayoutCubit()..getUserData()..getAllQuizzes()..getAllAttendance(lang)),
          BlocProvider(create: (context) => AttendanceCubit()..getUserData()..getMembers()),
          BlocProvider(create: (context) => QuizzesCubit(),),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
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
