import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class EventSearch extends StatelessWidget {
  const EventSearch({super.key, this.onChanged, this.controller});

  final void Function(String)? onChanged;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SearchBar(
            onChanged: onChanged,
            hintText: localize.translate('search'),
            leading: Icon(Icons.search,color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(8),
            ),
            controller: controller,
            elevation: MaterialStateProperty.all<double>(2),
            textStyle: WidgetStatePropertyAll(TextStyle(color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white)),
            backgroundColor: WidgetStatePropertyAll(context.read<LocaleCubit>().isDark ? AppColors.white:AppColors.mirage),
            hintStyle: WidgetStatePropertyAll(TextStyle(color: context.read<LocaleCubit>().isDark ? AppColors.mirage:AppColors.white)),
          ),
        ),
      ],
    );
  }
}
