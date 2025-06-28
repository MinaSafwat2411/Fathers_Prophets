import 'dart:io';

import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/core/widgets/custom_loading.dart';
import 'package:fathers_prophets/presentation/cubit/events/cubit/events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../cubit/events/states/events_states.dart';
import '../../cubit/local/cubit/local_cubit.dart';
import 'event_enum.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    final localize = AppLocalizations.of(context);
    var cubit = BlocProvider.of<EventsCubit>(context);
    return BlocConsumer<EventsCubit, EventsStates>(builder: (context, state) =>
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
                localize.translate("add_event"), style: textTheme.titleLarge),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: (){
                        cubit.pickImage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.alto,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        alignment: Alignment.center,
                        child: cubit.image != null ? Image.file(cubit.image?? File(""),fit: BoxFit.cover,):Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload,color: AppColors.doveGray),
                            const SizedBox(width: 8),
                            Text(localize.translate("upload_image"),style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.doveGray
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.azureRadiance)
                          )
                      ),
                      dropdownMenuEntries: [
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.BIBLE,
                          label: localize.translate("bible"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.DOCTRINE,
                          label: localize.translate("doctrine"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.COPTIC,
                          label: localize.translate("coptic"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.RITUAL,
                          label: localize.translate("ritual"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.CHOIR,
                          label: localize.translate("choir"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.MELODIES,
                          label: localize.translate("melodies"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.FOOTBALL,
                          label: localize.translate("football"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.PINGPONG,
                          label: localize.translate("pingPong"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.VOLLEYBALL,
                          label: localize.translate("volleyball"),
                        ),
                        DropdownMenuEntry<EventEnum>(
                          value: EventEnum.CHESS,
                          label: localize.translate("chess"),
                        )
                      ],
                      onSelected: (value) {
                        cubit.onSelectEvent(value);
                      },
                      width: double.infinity,
                      hintText: localize.translate("select_event"),
                      menuStyle: MenuStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomBigTextField(
                      label: localize.translate("title"),
                      onChanged: (value){},
                      isDark: context.read<LocaleCubit>().isDark,
                      controller: cubit.titleController,
                      observe: false,
                      enable: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          cubit.selectDate(context);
                        },
                        child: Text(cubit.selectedDate==null? localize.translate("select_date"): cubit.formatDate(cubit.selectedDate??DateTime.now(),context.read<LocaleCubit>().lang), style: textTheme.titleLarge),
                      ),
                    ),
                  ],
                ),
              ),
              if(state is OnLoading)CustomLoading(isDark: context.read<LocaleCubit>().isDark)
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onPressed: () {
                cubit.onSubmit();
              },
              text: localize.translate('save'),
              isEnabled: cubit.selectedDate!=null && cubit.titleController.text.isNotEmpty,
              btnColor: AppColors.green,
              height: 56,
              isDark: false,
            ),
          ),
        ), listener: (context, state) {
          if (state is OnSuccess) {
            context.pop(true);
          }
        },
    );
  }
}
