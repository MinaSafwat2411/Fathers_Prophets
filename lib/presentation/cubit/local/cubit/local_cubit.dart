import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/services/cache_helper.dart';
import '../states/local_states.dart';

class LocaleCubit extends Cubit<LocaleStates> {
  LocaleCubit() : super(const LocaleInitial(Locale('en')));

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
      await CacheHelper.saveData(key: 'lang', value: languageCode);
      lang=languageCode;
      emit(LocaleUpdated(Locale(languageCode)));
    } catch (e) {
      emit(LocaleError(Locale(lang))); // Default fallback
    }
  }
  void changeTheme(bool isDark){
    this.isDark = isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    emit(DarkChanged(Locale(lang)));
  }
}
