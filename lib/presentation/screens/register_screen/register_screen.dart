import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/register/cubit/register_cubit.dart';
import '../../cubit/register/states/register_states.dart';
import '../onboarding_screen/widgets/onboarding_top_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<RegisterCubit, RegisterStates>(
      builder: (context, state) => Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              OnboardingTopButton(
                  isDark: context.read<LocaleCubit>().isDark,
                  index:0
              ),
            ],
          )
      ),
      listener: (context, state) {
      },
      buildWhen: (previous, current) => current is !InitialState,
    );
  }
}
