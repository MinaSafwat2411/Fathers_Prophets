import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../cubit/forgot_password/cubit/forgot_password_cubit.dart';
import '../../cubit/forgot_password/states/forgot_password_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ForgotPasswordCubit.get(context);
    final localize = AppLocalizations.of(context);
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title:  Text(localize.translate('forgot_password')),
          ),
          body:  Form(
            key: cubit.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    context.read<LocaleCubit>().isDark? 'assets/images/logo_dark.png': 'assets/images/logo_light.png',
                    fit: BoxFit.fill,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    localize.translate('forget_password_des'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  CustomBigTextField(
                    observe: false,
                    label: localize.translate('email'),
                    controller: cubit.emailController,
                    isDark: context.read<LocaleCubit>().isDark,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localize.translate('email_validation_1');
                      }
                      if (!Validators.isValidEmail(value)) {
                        return localize.translate('email_validation_2');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.forgotPassword();
                }
              },
              text: localize.translate('send_email'),
              isEnabled: true,
              btnColor: AppColors.green,
              height: 55,
              isDark: context.read<LocaleCubit>().isDark,
            ),
          ),
        ),
        listener: (context, state) {
          if(state is OnSuccess){
            showCustomSnackBar(
                context,
                localize.translate('email_sent'),
                icon: Icons.account_circle_outlined,
                color: AppColors.green
            );
            context.pop();
          }
          if (state is OnError) {
            showCustomSnackBar(
                context,
                state.error.toString(),
                icon: Icons.error,
                color: AppColors.red
            );
          }
        },
    );
  }
}
