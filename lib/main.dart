import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kanban_app/screens/first_screen.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox('myBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FirstScreen()
    );
  }
}