import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/firebase_endpoints.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../data/services/cache_helper.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/splash/cubit/splash_cubit.dart';
import '../../cubit/splash/states/splash_states.dart';
import '../../routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SplashCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<SplashCubit, SplashStates>(
      builder: (context, state) =>  Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image:context.read<LocaleCubit>().isDark? AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
                    height: 250,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                  if(state is OnError)Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      onPressed: () {
                        cubit.onNavigate(context.read<LocaleCubit>().isDark, CacheHelper.getData(key: 'uid') ?? '',CacheHelper.getData(key: 'isOpened') ?? false );
                      },
                      height: 56,
                      isDark: context.read<LocaleCubit>().isDark,
                      isEnabled: true,
                      text: localize.translate('refresh'),
                      btnColor: AppColors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text("${localize.translate('version')} ${FirebaseEndpoints.version}",style: textTheme.labelMedium),
                  )
                ],
              ),
              if(state is OnLoading) CustomLoading(isDark: context.read<LocaleCubit>().isDark)
            ],
          ),
        ),
      ),
      listener: (context, state) {
        switch (state) {
          case OnNavigateToOnBoardingScreen(): {context.goNamed(AppRoutes.onboarding.name);break;}
          case OnNavigateToLoginScreen(): {context.goNamed(AppRoutes.login.name);break;}
          case OnNavigateToHomeScreen(): {context.goNamed(AppRoutes.layout.name);break;}
          case OnRequestUpToDate(): {showCustomSnackBar(context, "Check your Update",color: AppColors.red,icon: Icons.update);}
          case OnNavigateToReviewScreen(): {context.goNamed(AppRoutes.review.name);break;}
          case OnError(): {
              showCustomSnackBar(
              context,
              state.message.toString(),
              icon: Icons.error,
              color: AppColors.red,
            );}
        }
      },
    );
  }
}
