import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart';
import 'package:fathers_prophets/presentation/cubit/add_member/states/add_member_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/google_drive_service.dart';

class AddMemberCubit extends Cubit<AddMemberStates>{
  AddMemberCubit() : super(InitialState());

  static AddMemberCubit get(context) => BlocProvider.of(context);

  var member = UserModel();
  var classId = "";
  TextEditingController nameController = TextEditingController();
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final GoogleDriveUploader uploader = GoogleDriveUploader();

  void addMember()async{
    emit(OnLoading());
    try{
      member = member.copyWith(name: nameController.text,classId: classId,isReviewed: true);
      var result = await usersUseCase.addNewMemberByDocId(member);
      member = member.copyWith(uid: result ??"");
      await uploader.addUserToJsonFile("13_UaD9tG4Gdo59f_WRHooGnNTzc55YmF", member);
      var members = CacheHelper.getMembersByClassId(classId);
      members.add(member);
      members.sort((a, b) => (a.name??"").compareTo(b.name??""));
      CacheHelper.saveMembersByClassId(members, classId);
      members = CacheHelper.getMembers();
      members.add(member);
      members.sort((a, b) => (a.name??"").compareTo(b.name??""));
      CacheHelper.saveMembers(members);
      nameController.clear();
      classId = "";
      await usersUseCase.updateApplyToAll(CacheHelper.getAdmins());
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
  }

  void onSelectClass(String value){
    classId = value;
    emit(OnSelectClass());
  }
}