
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/features/profile_screen/viewmodel/profile_state.dart';

import '../../../core/data_base/models/user.dart' as user_model;
import '../../../core/data_base/my_database.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

 static user_model.User? currentUser;

  //Future<user_model.User?>
  getUserFromDataBase() async {
    emit(ProfileLoading());
    try{
      var user =
      await MyDataBase.readUser(FirebaseAuth.instance.currentUser?.uid ?? "");
      currentUser = user;
      emit(ProfileSuccess(user!));
    }on Exception catch(e){
      emit(ProfileError(e.toString()));
    }
  }
}
