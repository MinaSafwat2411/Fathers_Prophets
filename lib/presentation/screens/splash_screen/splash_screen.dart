import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_snackbar.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/splash/cubit/splash_cubit.dart';
import '../../cubit/splash/states/splash_states.dart';
import '../../routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SplashCubit>(context);
    return BlocConsumer<SplashCubit, SplashStates>(
      builder: (context, state) =>  Scaffold(
        body: Center(
          child: Image(
            image:context.read<LocaleCubit>().isDark? AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
            height: 250,
            width: 250,
            fit: BoxFit.fill,
          ),
        ),
      ),
      listener: (context, state) {
        switch (state) {
          case OnNavigateToOnBoardingScreen(): {context.goNamed(AppRoutes.onboarding.name);break;}
          case OnNavigateToLoginScreen(): {context.goNamed(AppRoutes.login.name);break;}
          case OnNavigateToHomeScreen(): {context.goNamed(AppRoutes.layout.name);break;}
          case OnRequestUpToDate(): {showCustomSnackBar(context, "Check your Update",color: AppColors.red,icon: Icons.update);}
        }
      },
    );
  }
}
