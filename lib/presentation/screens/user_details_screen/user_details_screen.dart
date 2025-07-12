import 'package:cached_network_image/cached_network_image.dart';
import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/screens/user_details_screen/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../core/widgets/profile_loading_image.dart';
import '../../../data/models/comment/comment_model.dart';
import '../../cubit/comment/cubit/comment_cubit.dart';
import '../../cubit/comment/states/comment_states.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../routes.dart';


class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
    required this.uid,
    required this.football,
    required this.volleyball,
    required this.pingPong,
    required this.chess,
    required this.melodies,
    required this.choir,
    required this.ritual,
    required this.coptic,
    required this.doctrine,
    required this.bible,
    required this.pray,
    required this.praise,
  });

  final String uid;
  final int football;
  final int volleyball;
  final int pingPong;
  final int chess;
  final int melodies;
  final int choir;
  final int ritual;
  final int coptic;
  final int doctrine;
  final int bible;
  final int pray;
  final int praise;

  @override
  Widget build(BuildContext context) {
    var cubit = CommentCubit.get(context)..getUserData(uid);
    final localize = AppLocalizations.of(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<CommentCubit, CommentStates>(
      listener: (context, state) {
        if (state is CommentError) {
          showCustomSnackBar(
            context,
            state.message.toString(),
            icon: Icons.error,
            color: AppColors.red,
          );
        }
      },
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(localize.translate("user_details")),
              leading: IconButton(
                onPressed: () {
                  context.pop(true);
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
              ),
              actions: [
                TextButton(onPressed: () async{
                  final pinResult = await context.pushNamed(
                    AppRoutes.pin.name,
                    extra: AppRoutes.reviewUser.name,
                  );
                  if (pinResult == true) {
                    var result = await context.pushNamed(
                      AppRoutes.reviewUser.name,
                      extra: cubit.user,
                    );
                    if(result == true){
                      context.pop(true);
                      return;
                    }
                    if (result != null) {
                      cubit.user = result as UserModel;
                      cubit.getAttendance(cubit.user.uid ?? "");
                    }
                  }
                }, child: Text(localize.translate('edit'),style: textTheme.titleMedium,))
              ],
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    cubit.user.profile == ''?ClipOval(
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
                          imageUrl: cubit.user.profile??"",
                          placeholder: (context, imageProvider) => ProfileLoadingImage(
                            isDark: context.read<LocaleCubit>().isDark,
                          ),
                          errorWidget: (context, url, error) =>  ProfileLoadingImage(
                            isDark: context.read<LocaleCubit>().isDark,
                          ),
                        )
                    ),
                    const SizedBox(height: 5),
                    Text(cubit.user.name ?? "", style: textTheme.titleLarge),
                  ],
                ),
                (state is! OnLoading )?Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.account_circle_outlined),
                              SizedBox(width: 8,),
                              Text(
                                "UID : ${cubit.user.uid ?? ""}",
                                style: textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.people_alt_outlined),
                              SizedBox(width: 8,),
                              Text(
                                "${localize.translate('class')} : ${cubit.classes.firstWhere((element) => element.docId==cubit.user.classId,).name}",
                                style: textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'football',
                          length: cubit.attendance.football?.length??0,
                          total: football,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'volleyball',
                          length: cubit.attendance.volleyball?.length??0,
                          total: volleyball,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'pingpong',
                          length: cubit.attendance.pingPong?.length??0,
                          total: pingPong,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'chess',
                          length: cubit.attendance.chess?.length??0,
                          total: chess,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'melodies',
                          length: cubit.attendance.melodies?.length??0,
                          total: melodies,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'choir',
                          length: cubit.attendance.choir?.length??0,
                          total: choir,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'ritual',
                          length: cubit.attendance.ritual?.length??0,
                          total: ritual,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'coptic',
                          length: cubit.attendance.coptic?.length??0,
                          total: coptic,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'doctrine',
                          length: cubit.attendance.doctrine?.length??0,
                          total: doctrine,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'bible',
                          length: cubit.attendance.bible?.length??0,
                          total: bible,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'pray',
                          length: cubit.attendance.pray?.length??0,
                          total: pray,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'praise',
                          length: cubit.attendance.praise?.length??0,
                          total: praise,
                        ),
                        SizedBox(height: 8,),
                     ]
                  ),
                ),
                ):Shimmer.fromColors(
                  baseColor: context.read<LocaleCubit>().isDark? AppColors.riverBed:AppColors.gray,
                  highlightColor: AppColors.white,
                  child: Container(
                    height: 800,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all((Radius.circular(20))),
                      color: AppColors.gray20,
                    ),
                  ),
                ),
                if (state is!CommentLoading) cubit.comments.isNotEmpty? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: cubit.comments.length,
                    itemBuilder: (context, index) {
                      final comment = cubit.comments[index];
                      return Slidable(
                        startActionPane: ActionPane(
                          extentRatio: 0.5,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                flex: 1,
                                onPressed: (context) => cubit.deleteComment(comment.id??""),
                                backgroundColor: context.read<LocaleCubit>().isDark? AppColors.white:AppColors.riverBed,
                                foregroundColor: AppColors.red,
                                icon: Icons.delete,
                                label: localize.translate('delete'),
                              ),
                            ]
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text("${index+1}) ${comment.content}",style: textTheme.titleMedium,maxLines: 10,),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                  ):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(localize.translate('no_comments'),textAlign: TextAlign.center,style: textTheme.labelLarge,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBigTextField(
                    border: 28,
                    controller: cubit.commentController,
                    isDark: context.read<LocaleCubit>().isDark,
                    observe: false,
                    label: localize.translate("add_comment"),
                    suffix: IconButton(
                      onPressed:
                          () => cubit.addComment(
                            CommentModel(
                              content: cubit.commentController.text,
                              authorId: cubit.user.uid ?? "",
                              timestamp: DateTime.now().millisecondsSinceEpoch,
                            ),
                          ),
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
