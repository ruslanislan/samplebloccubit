import 'package:flutter/cupertino.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditTodoError extends EditTodoState {
  final String error;

  EditTodoError({required this.error});
}

class TodoEdited extends EditTodoState {}