import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../main.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import '../../cubit/local/states/local_states.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LocaleCubit>();
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    return BlocConsumer<LocaleCubit, LocaleStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(localize.translate("settings"),
              style: textTheme.titleLarge
          ),
          leading: IconButton(onPressed: () {
            context.pop(cubit.isDark);
          }, icon: const Icon(Icons.arrow_back_ios_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localize.translate("dark_mode"),style: textTheme.titleSmall,),
                    Switch(value: cubit.isDark, onChanged: (value) {
                      cubit.changeTheme(value);
                    },
                      activeColor: AppColors.white,
                      inactiveThumbColor: AppColors.mirage,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: AppColors.slateGray,),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: bottomSheetTheme.backgroundColor,
                      shape: bottomSheetTheme.shape,
                      builder: (BuildContext context) {
                        return CustomBottomSheet(
                          title: localize.translate("select_language"),
                          isDark: cubit.isDark,
                          widget: Expanded(
                            child: ListView.separated(
                              itemCount: 2,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: ()async{
                                  cubit.changeLanguage([
                                    "en",
                                    "ar"
                                  ][index]);
                                  context.pop();
                                },
                                child: SizedBox(
                                  height: 60,
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Text(
                                        [
                                          localize.translate("en"),
                                          localize.translate("ar"),
                                        ][index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => const SizedBox(height: 8),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localize.translate("language"),style: textTheme.titleSmall,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(localize.translate(cubit.lang),style: textTheme.titleSmall,),
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
      listener: (context, state) {
        if (state is DarkChanged) {
          runApp(MyApp(isDark: cubit.isDark,lang: cubit.lang));
        }
      },
      buildWhen: (previous, current) => current is! LocaleInitial,
    );
  }
}
