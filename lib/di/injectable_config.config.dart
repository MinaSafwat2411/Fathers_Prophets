// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fathers_prophets/data/repositories/admin_pin/admin_pin_repository.dart'
    as _i1072;
import 'package:fathers_prophets/data/repositories/admin_pin/i_admin_pin_repository.dart'
    as _i910;
import 'package:fathers_prophets/data/repositories/attendance/attendance_repository.dart'
    as _i766;
import 'package:fathers_prophets/data/repositories/attendance/i_attendance_repository.dart'
    as _i707;
import 'package:fathers_prophets/data/repositories/auth/auth_repository.dart'
    as _i791;
import 'package:fathers_prophets/data/repositories/auth/i_auth_repository.dart'
    as _i643;
import 'package:fathers_prophets/data/repositories/chatbot/chatbot_repository.dart'
    as _i763;
import 'package:fathers_prophets/data/repositories/chatbot/i_chatbot_repository.dart'
    as _i820;
import 'package:fathers_prophets/data/repositories/classes/class_repository.dart'
    as _i852;
import 'package:fathers_prophets/data/repositories/classes/i_class_repository.dart'
    as _i551;
import 'package:fathers_prophets/data/repositories/eventattendance/event_attendance_repository.dart'
    as _i943;
import 'package:fathers_prophets/data/repositories/eventattendance/i_event_attendance_repository.dart'
    as _i205;
import 'package:fathers_prophets/data/repositories/events/events_repository.dart'
    as _i524;
import 'package:fathers_prophets/data/repositories/events/i_events_repository.dart'
    as _i714;
import 'package:fathers_prophets/data/repositories/quizzes/i_quizzes_repository.dart'
    as _i490;
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart'
    as _i14;
import 'package:fathers_prophets/data/repositories/quizzes_score/i_quizzes_score_repository.dart'
    as _i125;
import 'package:fathers_prophets/data/repositories/quizzes_score/quizzes_score_repository.dart'
    as _i571;
import 'package:fathers_prophets/data/repositories/splash/i_splash_repository.dart'
    as _i130;
import 'package:fathers_prophets/data/repositories/splash/splash_repository.dart'
    as _i426;
import 'package:fathers_prophets/data/repositories/users/i_users_repository.dart'
    as _i123;
import 'package:fathers_prophets/data/repositories/users/users_repository.dart'
    as _i159;
import 'package:fathers_prophets/data/services/cache/cache_helper.dart'
    as _i824;
import 'package:fathers_prophets/data/services/cache/i_cache_helper.dart'
    as _i917;
import 'package:fathers_prophets/data/services/drive/google_drive_service.dart'
    as _i859;
import 'package:fathers_prophets/data/services/drive/i_google_drive_service.dart'
    as _i440;
import 'package:fathers_prophets/domain/usecases/admin_pin/admin_pin_use_case.dart'
    as _i39;
import 'package:fathers_prophets/domain/usecases/admin_pin/i_admin_pin_use_case.dart'
    as _i573;
import 'package:fathers_prophets/domain/usecases/attendance/attendance_use_case.dart'
    as _i188;
import 'package:fathers_prophets/domain/usecases/attendance/i_attendance_use_case.dart'
    as _i805;
import 'package:fathers_prophets/domain/usecases/auth/auth_use_case.dart'
    as _i355;
import 'package:fathers_prophets/domain/usecases/auth/i_auth_use_case.dart'
    as _i884;
import 'package:fathers_prophets/domain/usecases/chatbot/chatbot_use_case.dart'
    as _i600;
import 'package:fathers_prophets/domain/usecases/chatbot/i_chatbot_use_case.dart'
    as _i1065;
import 'package:fathers_prophets/domain/usecases/classes/classes_use_case.dart'
    as _i83;
import 'package:fathers_prophets/domain/usecases/classes/i_classes_use_case.dart'
    as _i93;
import 'package:fathers_prophets/domain/usecases/eventattendance/event_attendance_use_case.dart'
    as _i33;
import 'package:fathers_prophets/domain/usecases/eventattendance/i_event_attendance_use_case.dart'
    as _i59;
import 'package:fathers_prophets/domain/usecases/events/events_use_case.dart'
    as _i925;
import 'package:fathers_prophets/domain/usecases/events/i_events_use_case.dart'
    as _i516;
import 'package:fathers_prophets/domain/usecases/quizzes/i_quizzes_use_case.dart'
    as _i1061;
import 'package:fathers_prophets/domain/usecases/quizzes/quizzes_use_case.dart'
    as _i771;
import 'package:fathers_prophets/domain/usecases/quizzes_score/i_quizzes_score_use_case.dart'
    as _i390;
import 'package:fathers_prophets/domain/usecases/quizzes_score/quizzes_score_use_case.dart'
    as _i291;
import 'package:fathers_prophets/domain/usecases/splash/i_splash_use_case.dart'
    as _i829;
import 'package:fathers_prophets/domain/usecases/splash/splash_use_case.dart'
    as _i321;
import 'package:fathers_prophets/domain/usecases/users/i_users_use_case.dart'
    as _i551;
import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart'
    as _i382;
import 'package:fathers_prophets/presentation/cubit/login/cubit/login_cubit.dart'
    as _i60;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i714.IEventsRepository>(() => _i524.EventsRepository());
    gh.lazySingleton<_i130.ISplashRepository>(() => _i426.SplashRepository());
    gh.lazySingleton<_i205.IEventAttendanceRepository>(
      () => _i943.EventAttendanceRepository(),
    );
    gh.lazySingleton<_i707.IAttendanceRepository>(
      () => _i766.AttendanceRepository(),
    );
    gh.lazySingleton<_i917.ICacheHelper>(() => _i824.CacheHelper());
    gh.lazySingleton<_i643.IAuthRepository>(() => _i791.AuthRepository());
    gh.lazySingleton<_i829.ISplashUseCase>(
      () => _i321.SplashUseCase(gh<_i130.ISplashRepository>()),
    );
    gh.lazySingleton<_i551.IClassRepository>(() => _i852.ClassRepository());
    gh.lazySingleton<_i490.IQuizzesRepository>(() => _i14.QuizzesRepository());
    gh.lazySingleton<_i125.IQuizzesScoreRepository>(
      () => _i571.QuizzesScoreRepository(),
    );
    gh.lazySingleton<_i910.IAdminPinRepository>(
      () => _i1072.AdminPinRepository(),
    );
    gh.lazySingleton<_i93.IClassesUseCase>(
      () => _i83.ClassesUseCase(gh<_i551.IClassRepository>()),
    );
    gh.lazySingleton<_i123.IUserRepository>(() => _i159.UserRepository());
    gh.lazySingleton<_i551.IUsersUseCase>(
      () => _i382.UsersUseCase(gh<_i123.IUserRepository>()),
    );
    gh.lazySingleton<_i820.IChatbotRepository>(() => _i763.ChatbotRepository());
    gh.lazySingleton<_i440.IGoogleDriveUploader>(
      () => _i859.GoogleDriveUploader(),
    );
    gh.lazySingleton<_i516.IEventsUseCase>(
      () => _i925.EventsUseCase(gh<_i714.IEventsRepository>()),
    );
    gh.lazySingleton<_i805.IAttendanceUseCase>(
      () => _i188.AttendanceUseCase(gh<_i707.IAttendanceRepository>()),
    );
    gh.lazySingleton<_i390.IQuizzesScoreUseCase>(
      () => _i291.QuizzesScoreUseCase(gh<_i125.IQuizzesScoreRepository>()),
    );
    gh.lazySingleton<_i1061.IQuizzesUseCase>(
      () => _i771.QuizzesUseCase(gh<_i490.IQuizzesRepository>()),
    );
    gh.lazySingleton<_i1065.IChatbotUseCase>(
      () => _i600.ChatbotUseCase(gh<_i820.IChatbotRepository>()),
    );
    gh.lazySingleton<_i573.IAdminPinUseCase>(
      () => _i39.AdminPinUseCase(gh<_i910.IAdminPinRepository>()),
    );
    gh.lazySingleton<_i59.IEventAttendanceUseCase>(
      () => _i33.EventAttendanceUseCase(gh<_i205.IEventAttendanceRepository>()),
    );
    gh.lazySingleton<_i884.IAuthUseCase>(
      () => _i355.AuthUseCase(gh<_i643.IAuthRepository>()),
    );
    gh.factory<_i60.LoginCubit>(
      () => _i60.LoginCubit(
        gh<_i884.IAuthUseCase>(),
        gh<_i551.IUsersUseCase>(),
        gh<_i93.IClassesUseCase>(),
        gh<_i1061.IQuizzesUseCase>(),
        gh<_i516.IEventsUseCase>(),
        gh<_i829.ISplashUseCase>(),
        gh<_i440.IGoogleDriveUploader>(),
        gh<_i917.ICacheHelper>(),
      ),
    );
    return this;
  }
}
