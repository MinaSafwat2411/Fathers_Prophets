import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:fathers_prophets/presentation/cubit/events/states/events_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class SelectMemberScreen extends StatelessWidget {
  const SelectMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<EventsCubit>(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<EventsCubit, EventsStates>(builder: (context, state) => Scaffold(
      appBar: AppBar(
        title: Text(localize.translate("select_member"),
          style: textTheme.titleLarge,
        ),
        leading: IconButton(onPressed: () async{
          context.pop(
            cubit.selectedMembers
          );
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand( // <-- this fixes the infinite height issue
          child: Column(
            children: [
              SearchBar(
                onChanged: (value) => cubit.onSearch(value),
                hintText: localize.translate('search'),
                leading: Icon(
                  Icons.search,
                  color: context.read<LocaleCubit>().isDark
                      ? AppColors.mirage
                      : AppColors.white,
                ),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(8),
                ),
                controller: cubit.searchController,
                elevation: WidgetStateProperty.all<double>(2),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: context.read<LocaleCubit>().isDark
                        ? AppColors.mirage
                        : AppColors.white,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  context.read<LocaleCubit>().isDark
                      ? AppColors.white
                      : AppColors.mirage,
                ),
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: context.read<LocaleCubit>().isDark
                        ? AppColors.mirage
                        : AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: state is! OnLoading
                    ? RefreshIndicator(
                  onRefresh: () async => cubit.onRefresh(),
                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: cubit.filteredClasses.length,
                                        separatorBuilder: (context, index) =>
                                        const SizedBox(height: 5),
                                        itemBuilder: (context, index) {
                      var member = cubit.filteredClasses[index].members;
                      return Column(
                        children: [
                          Text(cubit.filteredClasses[index].name??"",style: textTheme.titleMedium,),
                          for(int i=0;i<(member?.length??0);i++)GestureDetector(
                            onTap: () {
                              if (cubit.selectedMembers
                                  .any((e) => e.userId == member?[i].uid)) {
                                cubit.onRemoveMember(member?[i]??ClassUserModel());
                              } else {
                                cubit.onAddMember(member?[i]??ClassUserModel());
                              }
                            },
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(member?[i].name ?? "",
                                        style: textTheme.titleMedium),
                                  ),
                                  Checkbox(
                                    value: cubit.selectedMembers
                                        .any((e) => e.userId == member?[i].uid),
                                    onChanged: (_) {
                                      if (cubit.selectedMembers
                                          .any((e) => e.userId == member?[i].uid)) {
                                        cubit.onRemoveMember(member?[i]??ClassUserModel());
                                      } else {
                                        cubit.onAddMember(member?[i]??ClassUserModel());
                                      }
                                    },
                                    checkColor: AppColors.white,
                                    activeColor: AppColors.green,
                                    shape: const CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                                        },
                                      ),
                    )
                    : CustomLoading(
                  isDark: context.read<LocaleCubit>().isDark,
                ),
              ),
            ],
          ),
        ),
      ),
    ), listener: (context, state) {

    },);
  }
}
