import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/blocs/login_bloc/login_bloc.dart';
import 'package:kanban_app/screens/second_screen/second_screen.dart';
import 'package:kanban_app/screens/second_screen/third.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController(text: "");

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Пароль',
          // style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          // decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Form(
            key: _formKey,
            child: TextFormField(
              // key: _formKey,
              validator: (value) {
                if (value!.isEmpty) {
                  return '' /*'Пожалуйста, вводите текст'*/;
                }
                return null;
              },
              controller: _passwordController,
              // onEditingComplete: () {
              //   BlocProvider.of<LoginBloc>(_scaffoldkey.currentState.context)
              //       .add(LoginDoEvent(p12: ECP_FILE, password: "Qwerty12"));
              // },
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Введите пароль',
                // hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoadedState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThirdScreen()));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return Container(
                          height: double.infinity,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 120.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Login',
                                        hintText:
                                            'Enter valid mail id as abc@gmail.com'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                        hintText: 'Enter your secure password'),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          LoginDoEvent(
                                              username: "armada",
                                              password: "FSH6zBZ0p9yH"));
                                      // Navigator.push(
                                      //     context, MaterialPageRoute(builder: (_) => SecondScreen()));
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is LoginLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoginErrorState) {
                        return Center(
                          child: Text('LoginErrorState in first_screen.dart'),
                        );
                      } else {
                        return Center(
                          child: Text('Another error in first_screen.dart'),
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
