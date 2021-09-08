import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/blocs/main_bloc/main_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kanban'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'On hold',),
              Tab(text: 'In progress',),
              Tab(text: 'Needs review',),
              Tab(text: 'Approved',),
            ],
          ),
        ),
        body: BlocProvider<MainBloc>(
          create: (context) => MainBloc()..add(MainGetEvent(requestId: '0')),
          child: TabBarView(
            children: [
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state is MainLoadedState) {
                    return Card(
                      child: Container(
                        child: Text(state.mainJson.text),
                      ),
                    );
                  } else if (state is MainLoadingState || state is MainInitialState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MainErrorState) {
                    return Center(
                      child: Text('MainErrorState in second_screen.dart'),
                    );
                  } else {
                    return Center(
                      child: Text('Another error in second_screen.dart'),
                    );
                  }
                }
              ),
              BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state is MainLoadedState) {
                      return Card(
                        child: Container(
                          child: Text(state.mainJson.text),
                        ),
                      );
                    } else if (state is MainLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MainErrorState) {
                      return Center(
                        child: Text('MainErrorState in second_screen.dart'),
                      );
                    } else {
                      return Center(
                        child: Text('Another error in second_screen.dart'),
                      );
                    }
                  }
              ),
              BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state is MainLoadedState) {
                      return Card(
                        child: Container(
                          child: Text(state.mainJson.text),
                        ),
                      );
                    } else if (state is MainLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MainErrorState) {
                      return Center(
                        child: Text('MainErrorState in second_screen.dart'),
                      );
                    } else {
                      return Center(
                        child: Text('Another error in second_screen.dart'),
                      );
                    }
                  }
              ),
              BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state is MainLoadedState) {
                      return Card(
                        child: Container(
                          child: Text(state.mainJson.text),
                        ),
                      );
                    } else if (state is MainLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MainErrorState) {
                      return Center(
                        child: Text('MainErrorState in second_screen.dart'),
                      );
                    } else {
                      return Center(
                        child: Text('Another error in second_screen.dart'),
                      );
                    }
                  }
              ),
              // ListView.builder(
              //   itemCount: 6,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       child: Container(
              //         child: Text('asdfasdf'),
              //       ),
              //     );
              //   }
              // ),
              // ListView.builder(
              //     itemCount: 6,
              //     itemBuilder: (context, index) {
              //       return Card(
              //         child: Container(
              //           child: Text('asdf'),
              //         ),
              //       );
              //     }
              // ),
              // ListView.builder(
              //     itemCount: 6,
              //     itemBuilder: (context, index) {
              //       return Card(
              //         child: Container(
              //           child: Text('asdf'),
              //         ),
              //       );
              //     }
              // ),
              // ListView.builder(
              //     itemCount: 6,
              //     itemBuilder: (context, index) {
              //       return Card(
              //         child: Container(
              //           child: Text('asdf'),
              //         ),
              //       );
              //     }
              // ),
            ],
          ),
        )
      ),
    );
  }
}
