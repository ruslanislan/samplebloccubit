import 'package:flutter/cupertino.dart';
import 'package:samplebloccubit/data/models/todo.dart';

@immutable
abstract class TodosState {}

class TodosInitial extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded({required this.todos});
}

