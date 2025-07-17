import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.chatBot.name);
          },
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    context.read<LocaleCubit>().isDark? "assets/images/logo_dark.png": "assets/images/logo_light.png",
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 8,),
                  Text(
                    localize.translate('chatbot'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
              ],),
            ),
          ),
        )
      ],
    );
  }
}
