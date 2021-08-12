import 'package:flutter/foundation.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoError extends AddTodoState {
  final String error;

  AddTodoError({required this.error});
}

class AddingTodo extends AddTodoState {}
class TodoAdded extends AddTodoState {}