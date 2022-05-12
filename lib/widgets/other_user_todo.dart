import 'package:flutter/material.dart';
import 'package:notes_app/extensions/string.dart';
import 'package:notes_app/model/todo.dart';
import 'package:notes_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

import '../model/other_todos.dart';
import '../provider/todo_provider.dart';

class OtherUserTodo extends StatefulWidget {
  const OtherUserTodo({Key? key}) : super(key: key);

  @override
  State<OtherUserTodo> createState() => _OtherUserTodoState();
}

class _OtherUserTodoState extends State<OtherUserTodo> {
  late Future<List<Todos>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = TodosProvider().getOtherTodos();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<TodosProvider>(context);

    // futureTodos = provider.getOtherTodos();

    return FutureBuilder<List<Todos>>(
        future: futureTodos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => Container(height: 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final t = snapshot.data![index];
                // return TodoWidget(todo: t);

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.title.uppercaseFirst(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
    // ? const Center(
    //     child: Text(
    //       'No completed tasks.',
    //       style: TextStyle(fontSize: 20),
    //     ),
    //   )
    // : ListView.separated(
    //     physics: const BouncingScrollPhysics(),
    //     padding: const EdgeInsets.all(16),
    //     separatorBuilder: (context, index) => Container(height: 8),
    //     itemCount: todos.length,
    //     itemBuilder: (context, index) {
    //       final t = todos[index];

    //       return TodoWidget(todo: t);
    //     },
    //   );
  }
}
