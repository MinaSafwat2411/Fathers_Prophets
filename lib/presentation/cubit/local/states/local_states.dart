import 'package:flutter/material.dart';


abstract class LocaleStates {
  final Locale locale;
  const LocaleStates(this.locale);
}

class LocaleInitial extends LocaleStates {
  const LocaleInitial(super.locale);
}

class LocaleUpdated extends LocaleStates {
  const LocaleUpdated(super.locale);
}

class LocaleError extends LocaleStates {
  const LocaleError(super.locale);
}

class LocaleLoading extends LocaleStates {
   LocaleLoading(super.locale);
}

class DarkChanged extends LocaleStates {
  const DarkChanged(super.locale);
}
