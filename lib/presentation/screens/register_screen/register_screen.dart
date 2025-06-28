import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/custom_snackbar.dart';
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
    return WillPopScope(
      onWillPop: () {
        if (cubit.currentIndex == 0) {
          cubit.clear();
          return Future.value(true);
        } else {
          cubit.onPrev();
          return Future.value(false);
        }
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        builder:
            (context, state) => Stack(
              alignment: Alignment.center,
              children: [
                Scaffold(
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          OnboardingTopButton(
                            isDark: context.read<LocaleCubit>().isDark,
                            index: cubit.currentIndex,
                            total: 2,
                          ),
                          Image(
                            image:context.read<LocaleCubit>().isDark? AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageView(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                controller: cubit.pageController,
                                children: [
                                  Form(
                                    key: cubit.formKey1,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 16,),
                                        CustomBigTextField(
                                          controller: cubit.nameController,
                                          isDark: context.read<LocaleCubit>().isDark,
                                          label: localize.translate('name'),
                                          observe: false,
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return localize.translate('enter_name');
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 16,),
                                        CustomBigTextField(
                                          controller: cubit.emailController,
                                          isDark: context.read<LocaleCubit>().isDark,
                                          label: localize.translate('email'),
                                          observe: false,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return localize.translate('email_validation_1');
                                            }
                                            if (!Validators.isValidEmail(value)) {
                                              return localize.translate('email_validation_2');
                                            }
                                            return null;
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                  Form(
                                    key: cubit.formKey2,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 16,),
                                        CustomBigTextField(
                                          controller: cubit.passwordController,
                                          isDark: context.read<LocaleCubit>().isDark,
                                          label: localize.translate('password'),
                                          suffix: IconButton(onPressed: () => cubit.onPasswordObscure(),icon: Icon(cubit.isPasswordObscure? Icons.visibility_off : Icons.visibility),),
                                          observe: cubit.isPasswordObscure,
                                            validator: (value){
                                              if(Validators.isValidPassword(value??"")){
                                                return null;
                                              }else{
                                                return localize.translate('password_validation_1');
                                              }
                                            }
                                        ),
                                        SizedBox(height: 16,),
                                        CustomBigTextField(
                                          controller: cubit.confirmPasswordController,
                                          isDark: context.read<LocaleCubit>().isDark,
                                          label: localize.translate('confirm_password'),
                                          observe: cubit.isConfirmPasswordObscure,
                                          suffix: IconButton(onPressed: () => cubit.onConfirmPasswordObscure(),icon: Icon(cubit.isConfirmPasswordObscure? Icons.visibility_off : Icons.visibility),),
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return localize.translate('enter_confirm_password');
                                            }
                                            if (p0 != cubit.passwordController.text) {
                                              return localize.translate('password_not_match');
                                            }
                                            return null;
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenu(
                                    inputDecorationTheme: InputDecorationTheme(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(color: AppColors.azureRadiance)
                                        )
                                    ),
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry<String>(
                                        value: "2uli6QXyKY8VrpjMz99H",
                                        label: "ابونا ابراهيم",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "8aB4mDsvky0FbzOQwfTU",
                                        label: "دانيال النبي",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "9l6zfZIO1C6OavYCvuRV",
                                        label: "امنا سارة",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "bCkH6KkCRnEDMk5Ea6sf",
                                        label: "حنه النبيه",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "el2A2Mjm45SU5jliE29g",
                                        label: "دبورة النبية",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "f0nBkPZu9OJbQ0Hstqij",
                                        label: "امنا رفقة",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "fE4xWCz3bvBhyZeMuk7g",
                                        label: "ابونا اسحق",
                                      ),
                                      DropdownMenuEntry<String>(
                                        value: "nXB5fzKgjVkIrVrXrLDo",
                                        label: "موسي النبي",
                                      ),
                                    ],
                                    onSelected: (value) {
                                      cubit.onClassSelected(value??"");
                                    },
                                    width: double.infinity,
                                    hintText: localize.translate("select_class"),
                                    menuStyle: MenuStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (state is OnLoadingState) CustomLoading(isDark: context.read<LocaleCubit>().isDark),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      onPressed: () {
                        switch(cubit.currentIndex){
                          case 0:
                            if (cubit.formKey1.currentState!.validate()) {
                              cubit.onNext();
                            }
                            break;
                          case 1:
                            if (cubit.formKey2.currentState!.validate()) {
                              cubit.onNext();
                            }
                            break;
                          case 2:
                            cubit.onRegister();
                            break;
                        }
                      },
                      text: localize.translate('next'),
                      isEnabled: cubit.currentIndex ==2 && cubit.selectedClass != ""? true : cubit.currentIndex !=2? true :false,
                      btnColor: AppColors.green,
                      height: 55,
                      isDark: context.read<LocaleCubit>().isDark,
                    ),
                  ),
                ),
                if (state is OnLoadingState)
                  CustomLoading(isDark: context.read<LocaleCubit>().isDark),
              ],
            ),
        listener: (context, state) {
          if (state is OnSuccessState) {
            context.pop();
          }
          if (state is OnErrorState) {
            showCustomSnackBar(
                context,
                state.error.toString(),
                icon: Icons.error,
                color: AppColors.red
            );
          }
        },
        buildWhen: (previous, current) => current is! InitialState,
      ),
    );
  }
}
