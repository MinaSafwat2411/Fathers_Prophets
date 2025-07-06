import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/google_drive_service.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/review_user_states.dart';

class ReviewUserCubit extends Cubit<ReviewUserStates>{
  ReviewUserCubit() : super(InitialState());

  static ReviewUserCubit get(context) => BlocProvider.of(context);
  var user = UserModel();
  var classId = "";
  var className = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController role = TextEditingController();
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final GoogleDriveUploader uploader = GoogleDriveUploader();

  void onReviewUser()async{
    emit(OnLoadingState());
    try{
      user = user.copyWith(name: nameController.text,role: role.text);
      await usersUseCase.updateUser(user);
      if(user.isReviewed??false){
        if(user.isTeacher??false){
          await uploader.updateUserInJsonFile("1ZRKteCLH4oh2LRhqCmh3Sz7ZdCfSpFIm",user);
          var servants = CacheHelper.getServantsByClassId(user.classId??"");
          servants.add(user);
          servants.sort((a, b) => a.name!.compareTo(b.name!));
          if(user.isAdmin??false){
            await uploader.updateUserInJsonFile("1e8uAyL3twahG6B-odWAxjpAo4VmAYDEc",user);
            var admins = CacheHelper.getAdmins();
            admins.add(user);
            admins.sort((a, b) => a.name!.compareTo(b.name!));
            await CacheHelper.saveAdmins(admins);
          }else{
            await uploader.deleteUserFromJsonFile("1e8uAyL3twahG6B-odWAxjpAo4VmAYDEc",user.uid??"");
          }
        }else{
          await uploader.deleteUserFromJsonFile("1ZRKteCLH4oh2LRhqCmh3Sz7ZdCfSpFIm",user.uid??"");
          await uploader.updateUserInJsonFile("13_UaD9tG4Gdo59f_WRHooGnNTzc55YmF",user);
          var members = CacheHelper.getMembersByClassId(user.classId??"");
          members.add(user);
          members.sort((a, b) => a.name!.compareTo(b.name!));
          await CacheHelper.saveMembersByClassId(members, user.classId??"");
          members = CacheHelper.getMembers();
          members.add(user);
          members.sort((a, b) => a.name!.compareTo(b.name!));
          await CacheHelper.saveMembers(members);
        }
      }
      emit(OnSuccessState());
    }catch(e) {
      emit(OnErrorState(e.toString()));
    }
  }

  void onReview(bool value){
    user = user.copyWith(isReviewed: value);
    emit(OnReviewState());
  }
  void onAdmin(bool value){
    user = user.copyWith(isAdmin: value);
    emit(OnReviewState());
  }

  void onTeacher(bool value){
    user = user.copyWith(isTeacher: value);
    emit(OnReviewState());
  }

  void onClassSelected(String value){
    user = user.copyWith(classId: value);
    emit(OnClassSelectedState());
  }

  void onDelete()async{
    emit(OnLoadingState());
    try{
      await usersUseCase.deleteMember(user.uid??"");
      if(user.isTeacher??false) await uploader.deleteUserFromJsonFile("1ZRKteCLH4oh2LRhqCmh3Sz7ZdCfSpFIm",user.uid??"");
      if(user.isAdmin??false) await uploader.deleteUserFromJsonFile("1e8uAyL3twahG6B-odWAxjpAo4VmAYDEc",user.uid??"");
      if(user.isReviewed??false) await uploader.deleteUserFromJsonFile("13_UaD9tG4Gdo59f_WRHooGnNTzc55YmF",user.uid??"");
      var members = CacheHelper.getMembers();
      members.removeWhere((element) => element.uid == user.uid);
      await CacheHelper.saveMembers(members);
      var servants = CacheHelper.getServantsByClassId(user.classId??"");
      servants.removeWhere((element) => element.uid == user.uid);
      await CacheHelper.saveServantsByClassId(servants, user.classId??"");
      var admins = CacheHelper.getAdmins();
      admins.removeWhere((element) => element.uid == user.uid);
      await CacheHelper.saveAdmins(admins);
      members = CacheHelper.getMembersByClassId(user.classId??"");
      members.removeWhere((element) => element.uid == user.uid);
      await CacheHelper.saveMembersByClassId(members, user.classId??"");
      emit(OnDeleteUser());
    }catch(e){
      emit(OnErrorState(e.toString()));
    }

  }
}