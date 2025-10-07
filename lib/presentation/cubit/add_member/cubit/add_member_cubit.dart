import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/cubit/add_member/states/add_member_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/cache/i_cache_helper.dart';
import '../../../../domain/usecases/classes/i_classes_use_case.dart';
import '../../../../domain/usecases/users/i_users_use_case.dart';

class AddMemberCubit extends Cubit<AddMemberStates>{
  AddMemberCubit(this.usersUseCase,this.classesUseCase,this.cacheHelper) : super(InitialState());
  static AddMemberCubit get(context) => BlocProvider.of(context);

  var member = UserModel();
  List<ClassModel> classes= <ClassModel>[];
  ClassModel selectedClass = ClassModel();
  TextEditingController nameController = TextEditingController();
  final IUsersUseCase usersUseCase;
  final IClassesUseCase classesUseCase;
  final ICacheHelper cacheHelper;

  void addMember()async{
    emit(OnLoading());
    try{
      member = member.copyWith(name: nameController.text,classId: selectedClass.docId,isReviewed: true);
      var result = await usersUseCase.addNewMemberByDocId(member);
      member = member.copyWith(uid: result ??"");
      var classes = cacheHelper.getClasses();
      for(var i = 0; i<classes.length;i++){
        if(classes[i].docId==selectedClass.docId){
          classes[i].members?.add(ClassUserModel(
            isTeacher: false,
            uid: member.uid,
            name: member.name
          ));
          await classesUseCase.updateClass(classes[i]);
          classes[i].members?.sort((a, b) => (a.name??"").compareTo(b.name??""));
          break;
        }
      }
      await cacheHelper.saveClasses(classes);
      nameController.clear();
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
  }

  void  getData(){
    classes = cacheHelper.getClasses();
    emit(OnGetData());
  }
  void onSelectClass(ClassModel item){
    selectedClass = item;
    emit(OnSelectClass());
  }
}