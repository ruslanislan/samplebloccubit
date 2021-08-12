import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/cubit/todos_state.dart';
import 'package:samplebloccubit/data/models/todo.dart';
import 'package:samplebloccubit/data/repository.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() async {
    Timer(Duration(seconds: 1), () async {
      repository.fetchTodos().then((todos) => {
            emit(
              TodosLoaded(todos: todos),
            )
          });
      // final todos = await repository.fetchTodos();
      // emit(TodosLoaded(todos: todos));
    });
  }

  void changeCompletion(Todo todo) {
    repository
        .changeCompletion(!todo.isCompleted, todo.id)
        .then((isChanged) => {
              if (isChanged)
                {
                  todo.isCompleted = !todo.isCompleted,
                  updateTodoList(),
                }
            });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded)
      emit(
        TodosLoaded(todos: currentState.todos),
      );
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(
        TodosLoaded(todos: todoList),
      );
    }
  }

  deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(
        TodosLoaded(todos: todoList),
      );
    }
  }
}
