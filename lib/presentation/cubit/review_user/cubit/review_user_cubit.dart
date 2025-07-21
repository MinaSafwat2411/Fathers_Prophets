import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/classes/class_user_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/classes/class_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../domain/usecases/classes/classes_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/review_user_states.dart';

class ReviewUserCubit extends Cubit<ReviewUserStates>{
  ReviewUserCubit() : super(InitialState());

  static ReviewUserCubit get(context) => BlocProvider.of(context);
  var user = UserModel();
  var classId = "";
  var className = "";
  List<ClassModel> classes = <ClassModel>[];
  TextEditingController nameController = TextEditingController();
  TextEditingController role = TextEditingController();
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());


  void getData(){
    classes = CacheHelper.getClasses();
    emit(OnGetData());
  }
  void onReviewUser()async{
    emit(OnLoadingState());
    try{
      user = user.copyWith(name: nameController.text,role: role.text);
      await usersUseCase.updateUser(user);
      if(user.isTeacher??false){
        for(var i = 0; i<classes.length;i++){
          if(classes[i].docId==user.classId){
            classes[i].members?.removeWhere((element) => element.uid==user.uid);
            classes[i].servants?.add(ClassUserModel(
                isTeacher: user.isTeacher,
                uid: user.uid,
                name: user.name
            ));
            await classesUseCase.updateClass(classes[i]);
            break;
          }
        }
      }else{
        for(var i = 0; i<classes.length;i++){
          if(classes[i].docId==user.classId){
            classes[i].servants?.removeWhere((element) => element.uid==user.uid);
            classes[i].members?.add(ClassUserModel(
                isTeacher: user.isTeacher,
                uid: user.uid,
                name: user.name
            ));
            await classesUseCase.updateClass(classes[i]);
            break;
          }
        }
      }
      await CacheHelper.saveClasses(classes);
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
      for(var i = 0; i<classes.length;i++){
        if(classes[i].docId==classId){
          if(user.isTeacher??false){
            classes[i].servants?.removeWhere((element) => element.uid==user.uid,);
            await classesUseCase.removerMember(classes[i],ClassUserModel(
                isTeacher: user.isTeacher,
                uid: user.uid,
                name: user.name
            ));
          }else{
            classes[i].members?.removeWhere((element) => element.uid==user.uid,);
            await classesUseCase.removerMember(classes[i],ClassUserModel(
                isTeacher: user.isTeacher,
                uid: user.uid,
                name: user.name
            ));
          }
          break;
        }
      }
      await CacheHelper.saveClasses(classes);
      emit(OnDeleteUser());
    }catch(e){
      emit(OnErrorState(e.toString()));
    }

  }
}