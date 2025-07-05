import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/presentation/cubit/review_user/cubit/review_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/users/users_model.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/review_user/states/review_user_states.dart';

class ReviewUserScreen extends StatelessWidget {
  const ReviewUserScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<ReviewUserCubit>(context);
    cubit.user=user;
    cubit.nameController.text=user.name??'';
    cubit.role.text=user.role??'';
    return BlocConsumer<ReviewUserCubit, ReviewUserStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(localize.translate("review_user")),
            leading: IconButton(onPressed: () {
              context.pop();
            }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
          ),
          body: Stack(
            alignment:  Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(localize.translate("name")),
                      ),
                      SizedBox(height: 8,),
                      CustomBigTextField(controller: cubit.nameController, isDark: context.read<LocaleCubit>().isDark, label: localize.translate("name"), observe: false),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(localize.translate("role")),
                      ),
                      SizedBox(height: 8,),
                      CustomBigTextField(controller: cubit.role, isDark: context.read<LocaleCubit>().isDark, label: localize.translate("role"), observe: false),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(localize.translate("class")),
                      ),
                      SizedBox(height: 8,),
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
                        initialSelection: cubit.user.classId,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(localize.translate("reviewed")),
                          ),
                          Checkbox(
                            value: cubit.user.isReviewed,
                            onChanged: (value) {
                              cubit.onReview(value??false);
                            },
                            checkColor: AppColors.white,
                            activeColor: AppColors.green,
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(localize.translate("admin")),
                          ),
                          Checkbox(
                            value: cubit.user.isAdmin,
                            onChanged: (value) {
                              cubit.onAdmin(value??false);
                            },
                            checkColor: AppColors.white,
                            activeColor: AppColors.green,
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(localize.translate("teacher")),
                          ),
                          Checkbox(
                            value: cubit.user.isTeacher,
                            onChanged: (value) {
                              cubit.onTeacher(value??false);
                            },
                            checkColor: AppColors.white,
                            activeColor: AppColors.green,
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                    ]
                ),
              ),
              if(state is OnLoadingState) CustomLoading(isDark: context.read<LocaleCubit>().isDark)
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onPressed: () {
                cubit.onReviewUser();
              },
              text: localize.translate('save'),
              isEnabled: true,
              btnColor: AppColors.green,
              height: 56,
              isDark: false,
            ),
          ),
        ),
        listener: (context, state) {
          if(state is OnSuccessState){
            context.pop(cubit.user);
          }
          if(state is OnErrorState){
            showCustomSnackBar(context, state.error,color: AppColors.red, icon:Icons.error_outline);
          }
        },
    );
  }
}
