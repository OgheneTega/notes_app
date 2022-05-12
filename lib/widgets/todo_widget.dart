import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../provider/todo_provider.dart';
import '../screens/edit_todo.dart';
import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            startActionPane:
                ActionPane(motion: const DrawerMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.green,
                onPressed: (BuildContext context) {
                  editTodo(context, todo);
                },
                label: 'Edit',
                icon: Icons.edit,
              ),
            ]),
            endActionPane: ActionPane(motion: const DrawerMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (BuildContext context) {
                  deleteTodo(context, todo);
                },
                label: 'Delete',
                icon: Icons.delete,
              )
            ]),
            child: buildTodo(context)),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Task completed' : 'Task marked incomplete',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: const TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(
      context,
      'Deleted the task',
    );
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
