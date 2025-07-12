import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../cubit/add_member/cubit/add_member_cubit.dart';
import '../../cubit/add_member/states/add_member_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddMemberCubit.get(context);
    final localize = AppLocalizations.of(context);
    return BlocConsumer<AddMemberCubit, AddMemberStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(localize.translate("add_member")),
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body:  Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomBigTextField(
                          label: localize.translate("name"),
                          controller: cubit.nameController,
                          isDark: context.read<LocaleCubit>().isDark,
                          observe: false
                      ),
                      SizedBox(height: 16,),
                      DropdownMenu(
                        inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppColors.azureRadiance)
                            )
                        ),
                        dropdownMenuEntries: cubit.classes.map((e) => DropdownMenuEntry<ClassModel>(
                          value: e,
                          label: e.name??"",
                        ),).toList(),
                        onSelected: (value) {
                          cubit.onSelectClass(value ??ClassModel());
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
                      SizedBox(height: 16,),
                      CustomButton(
                          onPressed: () => cubit.addMember(),
                          text: localize.translate("add_member"),
                          isEnabled: cubit.nameController.text.isNotEmpty && cubit.selectedClass.docId!= '',
                          btnColor: AppColors.green,
                          height: 56,
                          isDark: context.read<LocaleCubit>().isDark
                      )
                    ],
                  ),
                ),
              ),
              if(state is OnLoading) CustomLoading(isDark: context.read<LocaleCubit>().isDark)
            ],
          ),
        ),
        listener: (context, state) {
        },
    );
  }
}
