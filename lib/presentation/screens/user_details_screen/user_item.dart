import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.length, required this.total, required this.title});
  final int length;
  final int total;
  final String title;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          context.read<LocaleCubit>().isDark?"assets/images/ic_${title}_dark.png":"assets/images/ic_${title}_light.png",
          width: 36,
          height: 36,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 8,),
        Text(
          "${localize.translate(title == "pingpong" ? "pingPong":title)} : $length / $total",
          style: textTheme.titleMedium,
        )
      ],
    );
  }
}
