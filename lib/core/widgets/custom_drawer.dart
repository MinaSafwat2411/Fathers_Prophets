import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/cubit/local/cubit/local_cubit.dart';
import '../../presentation/routes.dart';
import '../localization/app_localizations.dart';
import '../utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    var cubit =  LayoutCubit.get(context);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    return Drawer(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                context.pushNamed(AppRoutes.profile.name);
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  cubit.userData.uid !=''?ClipOval(
                    child: Image.asset(
                            context.read<LocaleCubit>().isDark? 'assets/images/logo_dark.png': 'assets/images/logo_light.png',
                            fit: BoxFit.fill,
                            width: 100,
                            height: 100,
                          )

                  ):Image.asset(
                    context.read<LocaleCubit>().isDark? 'assets/images/logo_dark.png': 'assets/images/logo_light.png',
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    cubit.userData.name??"",
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    localize.translate("drawer_profile_dec"),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.slateGray
                    ),
                  ),
                ],
              ),
            ),
            if(cubit.userData.isAdmin??false)SizedBox(height: 20,),
            if(cubit.userData.isAdmin??false)TextButton(onPressed: () => context.pushNamed(AppRoutes.dashBoard.name), child: Text(localize.translate("dash_board"),style: textTheme.titleLarge,)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: MaterialButton(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      size: 32,
                      color: iconTheme.color,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      localize.translate("settings"),
                      style: textTheme.titleLarge,
                    )
                  ],
                ),
                onPressed: () async {
                  await context.pushNamed(AppRoutes.settings.name);
                  if (!context.mounted) return;
                  cubit.getNewThemes(context.read<LocaleCubit>().lang);
                },
              ),
            )
          ]),
    );
  }
}
