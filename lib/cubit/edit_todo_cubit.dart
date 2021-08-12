import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/cubit/edit_todo_state.dart';
import 'package:samplebloccubit/cubit/todos_cubit.dart';
import 'package:samplebloccubit/data/models/todo.dart';
import 'package:samplebloccubit/data/repository.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  EditTodoCubit({required this.repository, required this.todosCubit}) : super(EditTodoInitial());

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo.id).then((isDeleted) => {
          if (isDeleted) {todosCubit.deleteTodo(todo), emit(TodoEdited())}
        });
  }

  void updateTodo(Todo todo, String message) {
    if (message.isEmpty) {
      emit(
        EditTodoError(error: 'message is empty'),
      );
    }

    repository.updateTodo(message, todo.id).then((isEdited) => {
          if (isEdited)
            {
              todo.todoMessage = message,
              todosCubit.updateTodoList(),
              emit(TodoEdited())
            }
        });
  }
}
