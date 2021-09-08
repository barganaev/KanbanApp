import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/models/login_model.dart';
import 'package:kanban_app/services/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginDoEvent) {
      yield LoginLoadingState();
      try {
        // model
        log('HELLO', name: 'HELLO');
        LoginModel loginModel = await ApiProvider().requestPost(
            RequestNames.login,
            username: event.username,
            password: event.password);
        log('Error!', name: 'LOGIN_BLOC');
        yield LoginLoadedState(loginModel: loginModel);
      } catch (e) {
        print(e.toString());
        yield LoginErrorState();
      }
    }
  }
}
