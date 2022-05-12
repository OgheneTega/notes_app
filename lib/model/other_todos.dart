// To parse this JSON data, do
//
//     final todos = todosFromMap(jsonString);

import 'dart:convert';

List<Todos> todosFromMap(String str) =>
    List<Todos>.from(json.decode(str).map((x) => Todos.fromMap(x)));

String todosToMap(List<Todos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Todos {
  Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  final int userId;
  final int id;
  final String title;
  final bool completed;

  factory Todos.fromMap(Map<String, dynamic> json) => Todos(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
