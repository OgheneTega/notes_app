import 'package:flutter/material.dart';
import 'package:notes_app/provider/todo_provider.dart';
import 'package:notes_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'Todo App';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: const Color(0xFFf6f5ee),
          ),
          home: const HomePage(),
        ),
      );
}
