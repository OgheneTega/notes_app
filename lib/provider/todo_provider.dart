import 'package:flutter/cupertino.dart';

import '../model/other_todos.dart';
import '../model/todo.dart';
import '../services/networking.dart';

const todosURL = "https://jsonplaceholder.typicode.com/todos";

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      DateTime.now(),
      createdTime: DateTime.now(),
      title: 'Buy Food 😋',
      description: '''- Eggs
- Milk
- Bread
- Water''',
    ),
    Todo(
      DateTime.now(),
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''- Rent some hotels
- Rent a car
- Pack suitcase''',
    ),
    Todo(
      DateTime.now(),
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕',
    ),
    Todo(
      DateTime.now(),
      createdTime: DateTime.now(),
      title: 'Plan Jacobs birthday party 🎉🥳',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  // void insertTodo(Todo todo) {
  //   _todos.insert(_todos.indexWhere((element) => true), todo);
  //   notifyListeners();
  // }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }

  Future<List<Todos>> getOtherTodos() async {
    var url = todosURL;
    NetworkHelper networkHelper = NetworkHelper(url);
    var todosData = await networkHelper.getData();

    var todosList = todosData.cast<Map<String, dynamic>>();

    return todosList.map<Todos>((json) => Todos.fromMap(json)).toList();
  }
}
