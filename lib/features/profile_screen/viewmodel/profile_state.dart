import '../../../core/data_base/models/user.dart' ;


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final User user;
  ProfileSuccess(this.user);
}
class ProfileError extends ProfileState{
   final String e;
    ProfileError(this.e);
}
