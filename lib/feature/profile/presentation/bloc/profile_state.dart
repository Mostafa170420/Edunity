class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final String? message;

  ProfileSuccessState({this.message});
}

class ProfileErrorState extends ProfileState {
  final String? message;

  ProfileErrorState(this.message);
}
