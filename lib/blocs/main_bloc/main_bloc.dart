import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/models/login_model.dart';
import 'package:kanban_app/models/main_model.dart';
import 'package:kanban_app/services/api_provider.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitialState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainGetEvent) {
      yield MainLoadingState();
      try {
        // model
        print('HELLO, IT IS ME!');
        MainModel mainModel = await ApiProvider().requestPost(RequestNames.cardsGet);
        print('HELLO, IT IS NOT ME!');
        yield MainLoadedState(mainJson: mainModel);
      } catch (e) {
        yield MainErrorState();
      }
    }
  }
}