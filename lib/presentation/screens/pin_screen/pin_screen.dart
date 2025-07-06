import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/pin/cubit/pin_cubit.dart';
import '../../cubit/pin/states/pin_states.dart';
import '../../routes.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key, required this.nextScreen});
  final String nextScreen;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = PinCubit.get(context);
    return BlocConsumer<PinCubit, PinStates>(
        builder: (context, state) => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Image(
                    image:context.read<LocaleCubit>().isDark? AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for(int i = 1; i < 5; i++)
                        Card(
                          color: cubit.pin.length >= i? AppColors.azureRadiance:AppColors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                          )
                        )
                    ]
                  ),
                  Spacer(),
                  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0,vertical: 16),
                child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 16,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                    ...List.generate(9, (index) {
                      return GestureDetector(
                        onTap: () {
                          cubit.onPinAdd((index+1).toString());
                        },
                        child: Container(
                          alignment:Alignment.center,
                          decoration: BoxDecoration(
                            color: context.read<LocaleCubit>().isDark? AppColors.riverBed : AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]
                          ),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text((index+1).toString(), style: textTheme.titleMedium,textAlign: TextAlign.center),
                            )
                        ),
                      );
                    },
                    ),
                      SizedBox(),
                      GestureDetector(
                        onTap: () {
                          cubit.onPinAdd((0).toString());
                        },
                        child: Container(
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: context.read<LocaleCubit>().isDark? AppColors.riverBed : AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]
                            ),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text((0).toString(), style: textTheme.titleMedium,textAlign: TextAlign.center),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.onPinRemove();
                        },
                        child: Container(
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: context.read<LocaleCubit>().isDark? AppColors.riverBed : AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]
                            ),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Icon(Icons.backspace_outlined, size: 20,),
                            )
                        ),
                      ),
                    ]),
              ),
                ]
              ),
            ),
            if(state is OnLoading) CustomLoading(isDark: context.read<LocaleCubit>().isDark)
          ],
        ),
        listener: (context, state) {
          if(cubit.pin.length == 4){
            if(state is! OnLoading && state is! OnSuccess){
              cubit.onSubmit();
            }
          }
          if(state is OnSuccess){
            if(nextScreen == AppRoutes.addMember.name) {
              context.pushReplacementNamed(nextScreen);
            } else {
              context.pop(true);
            }
          }
          if(state is OnError){
            showCustomSnackBar(
              context,
              state.error.toString(),
              icon: Icons.error,
              color: AppColors.red
            );
          }
          if(state is OnWrongPin){
            showCustomSnackBar(
              context,
              localize.translate('wrong_pin'),
              icon: Icons.error,
              color: AppColors.red
            );
          }
        },
    );
  }
}
