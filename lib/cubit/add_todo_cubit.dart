import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/cubit/add_todo_state.dart';
import 'package:samplebloccubit/cubit/todos_cubit.dart';
import 'package:samplebloccubit/data/repository.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  AddTodoCubit({required this.todosCubit, required this.repository}) : super(AddTodoInitial());

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }
    emit(AddingTodo());
    Timer(Duration(seconds: 1), () {
      repository.addTodo(message).then((todo) => {
            if (todo != null)
              {
                todosCubit.addTodo(todo),
                emit(
                  TodoAdded(),
                )
              }
          });
    });
  }
}
