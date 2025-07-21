import 'package:cached_network_image/cached_network_image.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/core/widgets/profile_loading_image.dart';
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
                  cubit.userData.profile == ''||cubit.userData.profile == null?ClipOval(
                    child: Image.asset(
                            context.read<LocaleCubit>().isDark? 'assets/images/logo_dark.png': 'assets/images/logo_light.png',
                            fit: BoxFit.fill,
                            width: 100,
                            height: 100,
                          )

                  ):ClipOval(
                      child: CachedNetworkImage(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        imageUrl: cubit.userData.profile??"",
                        placeholder: (context, imageProvider) => ProfileLoadingImage(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                        errorWidget: (context, url, error) =>  ProfileLoadingImage(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                      )
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
            SizedBox(height: 16,),
            if(cubit.userData.isAdmin??false)MaterialButton(
              onPressed: () {
                context.pushNamed(AppRoutes.dashBoard.name);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard_customize_outlined,color: iconTheme.color,size: 32,),
                  SizedBox(width: 8,),
                  Text(localize.translate("dash_board"),style: textTheme.titleLarge,),
                ],
              ),
            ),
            SizedBox(height: 16,),
            if(cubit.userData.canPreview??false)MaterialButton(
              onPressed: ()=>cubit.canPreview(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye_outlined,color: iconTheme.color,size: 32,),
                  SizedBox(width: 8,),
                  Text(localize.translate("preview_as_member"),style: textTheme.titleLarge,),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top : 24),
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text("${localize.translate('version')} ${FirebaseEndpoints.version}",style: textTheme.labelMedium),
            )
          ]),
    );
  }
}
