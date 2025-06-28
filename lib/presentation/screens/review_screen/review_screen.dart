import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image(
                image:context.read<LocaleCubit>().isDark? AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 8),
              Text(localize.translate('go_to_your_teacher'),style: textTheme.titleMedium,),
              SizedBox(height: 8),
              Text(CacheHelper.getUserData().uid??"",style: textTheme.titleMedium,),
              SizedBox(height: 20),
              CustomButton(
                  onPressed: () => context.goNamed(AppRoutes.login.name),
                  text: localize.translate('back_to_login'),
                  isEnabled: true,
                  btnColor: AppColors.green,
                  height: 56,
                  isDark: context.read<LocaleCubit>().isDark
              )
            ],
          ),
        ),
      )
    );
  }
}
