class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final String? message;

  HomeSuccessState({this.message});
}

class HomeErrorState extends HomeState {
  final String? message;

  HomeErrorState(this.message);
}
