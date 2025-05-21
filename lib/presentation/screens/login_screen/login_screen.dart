import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_big_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/login/cubit/login_cubit.dart';
import '../../cubit/login/states/login_states.dart';
import '../../routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (context, state) => Scaffold(
        body: Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Text(
                  localize.translate('app_name'),
                  style: textTheme.headlineLarge,
                ),
                const SizedBox(height: 25),
                CustomBigTextField(
                  observe: false,
                  label: localize.translate('email'),
                  controller: cubit.emailController,
                  isDark: false,
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
                const SizedBox(height: 25),
                CustomBigTextField(
                  observe: true,
                  label: localize.translate('password'),
                  controller: cubit.passwordController,
                  isDark: false,
                  validator: (value){
                    if(Validators.isValidPassword(value??"")){
                      return null;
                    }else{
                      return localize.translate('password_validation_1');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      localize.translate('forget_password_des'),
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.pushNamed(AppRoutes.forgotPassword.name);
                        cubit.authUseCase.sendPasswordResetEmail("minasafwat594@gmail.com");
                      },
                      child: Text(
                        localize.translate('click_here'),
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Spacer(),
                CustomButton(
                  height: 55,
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.login();
                    }
                  },
                  btnColor: context.read<LocaleCubit>().isDark ? AppColors.white : AppColors.mirage2,
                  text: state is LoginLoadingState? localize.translate('loading') :localize.translate('login'),
                  isEnabled: true,
                  isDark: context.read<LocaleCubit>().isDark,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      localize.translate('register_des'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.register.name);
                      },
                      child: Text(
                        localize.translate('register'),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          height: 1.50,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.goNamed(AppRoutes.layout.name);
        }
        if (state is LoginErrorState) {
          showCustomSnackBar(
            context,
            state.message.toString(),
            icon: Icons.error,
            color: AppColors.red
          );
        }
      },
      listenWhen: (previous, current) => current is LoginErrorState || current is LoginSuccessState ,
      buildWhen: (previous, current) =>
           current is LoginLoadingState,
    );
  }
}
