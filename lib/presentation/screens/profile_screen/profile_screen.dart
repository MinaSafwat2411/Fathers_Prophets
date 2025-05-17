import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/profile/cubit/profile_cubit.dart';
import '../../cubit/profile/states/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {
              context.pop();
            }, icon: Icon(Icons.arrow_back_ios)),
            title: Text(localize.translate("profile")),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localize.translate('account'),style: textTheme.titleMedium,),
                MaterialButton(onPressed: () {
                  cubit.onSignOut();
                },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppColors.red,
                      strokeAlign: 2
                    )
                  ),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.logout,color: AppColors.red,),
                      SizedBox(width: 8,),
                      Text("Logout",style: textTheme.titleSmall?.copyWith(
                        color: AppColors.red
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if(state is OnSignOut){
            context.goNamed(AppRoutes.login.name);
          }
        },
    );
  }
}
