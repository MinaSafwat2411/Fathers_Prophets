import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/presentation/cubit/layout/cubit/layout_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../cubit/dashboard/cubit/dashboard_cubit.dart';
import '../../cubit/dashboard/states/dashboard_states.dart';
import '../../routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = DashboardCubit.get(context);
    return BlocConsumer<DashboardCubit, DashboardStates>(
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(localize.translate("dash_board")),
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            body: PageView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu(
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
                          cubit.onSelectClass(value.toString());
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
                    ),
                    state is! OnLoading? Expanded(
                      child: ListView(
                        children: [
                          for(var item in cubit.members) TextButton(onPressed: () {
                            context.pushNamed(AppRoutes.userDetails.name, extra: {'user':item,
                              'football':context.read<LayoutCubit>().footballEvents.length,
                              'volleyball':context.read<LayoutCubit>().volleyballEvents.length,
                              'pingPong':context.read<LayoutCubit>().pingPongEvents.length,
                              'chess':context.read<LayoutCubit>().chessEvents.length,
                              'melodies':context.read<LayoutCubit>().melodiesEvents.length,
                              'choir':context.read<LayoutCubit>().choirEvents.length,
                              'ritual':context.read<LayoutCubit>().ritualEvents.length,
                              'coptic':context.read<LayoutCubit>().copticEvents.length,
                              'doctrine':context.read<LayoutCubit>().doctrineEvents.length,
                              'bible':context.read<LayoutCubit>().bibleEvents.length,
                              'pray':context.read<LayoutCubit>().prayEvents.length,
                              'praise':context.read<LayoutCubit>().praiseEvents.length,
                            });
                          }, child: Card(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item.name??'', style: textTheme.bodyLarge,),
                              ],
                            ),
                          )))
                          ]
                      ),
                    ):
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 1,
                            backgroundColor: AppColors.transparent,
                            color: context.read<LocaleCubit>().isDark? AppColors.white: AppColors.mirage
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
      listener: (context, state) {},
      buildWhen:
          (previous, current) =>
              current is OnFilter ||
              current is OnSuccess ||
              current is OnLoading,
    );
  }
}
