import 'package:cached_network_image/cached_network_image.dart';
import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:fathers_prophets/core/widgets/custom_button.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/event_shimmer_item.dart';
import '../../../data/models/events/event_attendance_model.dart';
import '../../cubit/events/cubit/events_cubit.dart';
import '../../cubit/events/states/events_states.dart';
import '../../cubit/layout/cubit/layout_cubit.dart';
import '../../cubit/local/cubit/local_cubit.dart';

class AddEventAttendance extends StatelessWidget {
  const AddEventAttendance({super.key, required this.event,required this.title});

  final EventsModel event;
  final String title;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    var cubit = BlocProvider.of<EventsCubit>(context);
    cubit.event = event;
    return WillPopScope(
      onWillPop: () {
        cubit.onRest();
        context.pop();
        return Future.value(false);
      },
      child: BlocConsumer<EventsCubit, EventsStates>(
        listener: (context, state) {
          if (state is OnSuccess) {
            cubit.onRest();
            context.pop(cubit.event);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              event.nameAr ?? '',
              style: textTheme.titleLarge,
            ),
            centerTitle: true,
            leading: IconButton(onPressed: () {
              cubit.onRest();
              context.pop();
            }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
            actions: [
              if(context.read<LayoutCubit>().userData.isAdmin??false)IconButton(onPressed: () {
                context.pushNamed(AppRoutes.eventAttendanceDetails.name,extra: cubit.event.attendance??<String>[]);
              }, icon: Icon(Icons.people_alt_outlined))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${event.title ?? ''} ${cubit.formatDate(event.dateTime ?? DateTime.now(), context.read<LocaleCubit>().lang)}",
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 8,),
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: event.image!= ''?CachedNetworkImage(
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: event.image ?? '',
                        placeholder:
                            (context, url) => EventShimmerItem(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                        errorWidget:
                            (context, url, error) => EventShimmerItem(
                          isDark: context.read<LocaleCubit>().isDark,
                        ),
                      ):Image.asset(context.read<LocaleCubit>().isDark?'assets/images/logo_dark.png': 'assets/images/logo_light.png',width: double.infinity,height: 200,fit: BoxFit.fill,),
                    ),
                  ),
                  if(context.read<LayoutCubit>().userData.isAdmin??false)Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: ()async {
                        var list = await context.pushNamed(AppRoutes.selectMember.name);
                        if(list==null){
                          return;
                        }else{
                          cubit.onBackDone(list as List<AttendanceEventModel>);
                        }
                      },
                      child: Text(
                        localize.translate("select_member"),
                        style: textTheme.titleLarge,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:
                        (context, index) => Card(
                      child: Column(
                        children: [Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(cubit.selectedMembers[index].name ?? "",style: textTheme.titleMedium,),
                        )],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: cubit.selectedMembers.length,
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: (context.read<LayoutCubit>().userData.isAdmin??false) ?Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomButton(
              onPressed: () {
                cubit.onEventAttendance(event.docId??"",title,event);
              },
              text: localize.translate('save'),
              isEnabled: cubit.selectedMembers.isNotEmpty,
              btnColor: AppColors.green,
              height: 56,
              isDark: false,
            ),
          ):SizedBox(),
        ),
      ),
    );
  }
}
