part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitialState extends MainState {}

class MainLoadedState extends MainState {
  // MyOrdersModel myOrdersModel;
  MainModel mainJson;
  // String mainJson;
  MainLoadedState({required this.mainJson});
}

class MainLoadingState extends MainState {}

class MainErrorState extends MainState {}
