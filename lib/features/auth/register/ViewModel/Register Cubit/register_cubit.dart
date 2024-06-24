import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/data_base/models/user.dart' as my_user;
import '../../../../../core/data_base/my_database.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  FirebaseAuth authService = FirebaseAuth.instance;

  register(
      {required String email,
      required String name,
      required String password,
      required String phone,
      }) async {


    emit(RegisterLoading());
    try {
      debugPrint("Try to register");
      var result = await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var myUser = my_user.User(id: result.user?.uid, name: name, email: email,phoneNumber: phone);
      ////////////////////////////////
      // if(authService.currentUser?.emailVerified == false){
      //   await authService.currentUser?.sendEmailVerification();
      //
      // }
      /////////////////////////////////////
      await MyDataBase.addUser(myUser);
      debugPrint("User Added");
      emit(RegisterSuccess('Success'));
      debugPrint("Success Register");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        String errorMessage = 'The password provided is too weak.';
        emit(RegisterError(errorMessage));
      } else if (e.code == 'email-already-in-use') {
        String errorMessage = 'The account already exists for that email.';
        emit(RegisterError(errorMessage));
      }
    } on TimeoutException catch (e) {
      emit(RegisterError(e.toString()));
    }
    catch (e) {
      String errorMessage = 'Something Went Wrong$e';
      emit(RegisterError(errorMessage));
    }
  }
}
