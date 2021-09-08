part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainGetEvent extends MainEvent {
  String requestId;
  MainGetEvent({required this.requestId});
}
