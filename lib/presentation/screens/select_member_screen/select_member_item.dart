import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../cubit/events/cubit/events_cubit.dart';

class SelectMemberItem extends StatelessWidget {
  const SelectMemberItem({super.key, required this.index, required this.className, required this.members});
  final int index;
  final String className;
  final List<UserModel> members;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var cubit = BlocProvider.of<EventsCubit>(context);
    return  SingleChildScrollView(
      child: Column(
        children: [
          Text(className,style: textTheme.titleLarge,),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap:(){
                  if(members.elementAt(index).checked??false){
                    cubit.onRemoveMember(members.elementAt(index));
                  }else{
                    cubit.onAddMember(members.elementAt(index));
                  }
                } ,
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(members.elementAt(index).name??"",style: textTheme.titleMedium),
                      ),
                      Checkbox(
                        value: cubit.selectedMembers.any((element) => element.userId == members.elementAt(index).uid),
                        onChanged: (value) {
                          if(value??false){
                            cubit.onAddMember(members.elementAt(index));
                          }else{
                            cubit.onRemoveMember(members.elementAt(index));
                          }
                        },
                        checkColor: AppColors.white,
                        activeColor: AppColors.green,
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder:(context, index) =>  SizedBox(),
              itemCount: members.length
          )
        ],
      ),
    );
  }
}
