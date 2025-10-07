import 'package:fathers_prophets/data/services/cache/i_cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../states/local_states.dart';

class LocaleCubit extends Cubit<LocaleStates> {
  LocaleCubit(this.cacheHelper) : super(const LocaleInitial(Locale('ar')));
  final ICacheHelper cacheHelper;
  static LocaleCubit get(context) => BlocProvider.of(context);
  var isDark = false;
  var lang= '';
  var uid ='';
  var isOpened=false;

  Future<void> loadSavedLocale(String lang,bool isDark) async {
    this.lang = lang;
    this.isDark = isDark;
    emit(LocaleUpdated(Locale(this.lang)));
    emit(DarkChanged(Locale(lang)));
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      emit(LocaleLoading(Locale(lang)));
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay
      await cacheHelper.saveData(key: 'lang', value: languageCode);
      lang=languageCode;
      emit(LocaleUpdated(Locale(languageCode)));
    } catch (e) {
      emit(LocaleError(Locale(lang))); // Default fallback
    }
  }
  void changeTheme(bool isDark){
    this.isDark = isDark;
    cacheHelper.saveData(key: 'isDark', value: isDark);
    emit(DarkChanged(Locale(lang)));
  }
}
