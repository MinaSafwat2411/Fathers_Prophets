import 'package:fathers_prophets/core/widgets/custom_big_textfield.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/cubit/local/cubit/local_cubit.dart';
import 'package:fathers_prophets/presentation/screens/user_details_screen/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/comment/comment_model.dart';
import '../../cubit/comment/cubit/comment_cubit.dart';
import '../../cubit/comment/states/comment_states.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
    required this.user,
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
    required this.quizzes,
  });

  final UserModel user;
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
  final int quizzes;

  @override
  Widget build(BuildContext context) {
    var cubit = CommentCubit.get(context)..listenToComments(user.uid ?? "");
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
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ClipOval(
                      child: Image.asset(
                        context.read<LocaleCubit>().isDark
                            ? 'assets/images/logo_dark.png'
                            : 'assets/images/logo_light.png',
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(user.name ?? "", style: textTheme.titleLarge),
                  ],
                ),
                Card(
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
                                "UID : ${user.uid ?? ""}",
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
                                "${localize.translate('class')} : ${cubit.classes.firstWhere((element) => element.docId==user.classId,).name ?? ""}",
                                style: textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'football',
                          length: user.football?.length??0,
                          total: football,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'volleyball',
                          length: user.volleyball?.length??0,
                          total: volleyball,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'pingpong',
                          length: user.pingPong?.length??0,
                          total: pingPong,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'chess',
                          length: user.chess?.length??0,
                          total: chess,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'melodies',
                          length: user.melodies?.length??0,
                          total: melodies,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'choir',
                          length: user.choir?.length??0,
                          total: choir,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'ritual',
                          length: user.ritual?.length??0,
                          total: ritual,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'coptic',
                          length: user.coptic?.length??0,
                          total: coptic,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'doctrine',
                          length: user.doctrine?.length??0,
                          total: doctrine,
                        ),
                        SizedBox(height: 8,),
                        UserItem(
                          title: 'bible',
                          length: user.bible?.length??0,
                          total: bible,
                        ),
                        SizedBox(height: 8,),
                     ]
                  ),
                ),
                ),
                if (state is CommentLoaded)state.comments.isNotEmpty? Card(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text("${index+1}) ${comment.content}",style: textTheme.titleMedium,),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
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
                              authorId: user.uid ?? "",
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
