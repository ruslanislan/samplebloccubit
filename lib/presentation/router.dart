import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/constants/strings.dart';
import 'package:samplebloccubit/cubit/add_todo_cubit.dart';
import 'package:samplebloccubit/cubit/edit_todo_cubit.dart';
import 'package:samplebloccubit/cubit/todos_cubit.dart';
import 'package:samplebloccubit/data/models/todo.dart';
import 'package:samplebloccubit/data/network_service.dart';
import 'package:samplebloccubit/data/repository.dart';
import 'package:samplebloccubit/presentation/screens/add_todo_screen.dart';
import 'package:samplebloccubit/presentation/screens/edit_todo_screen.dart';
import 'package:samplebloccubit/presentation/screens/todos_screen.dart';

class AppRouter {
  late Repository repository;
  late TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todosCubit,
                  child: TodosScreen(),
                ));
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(
              todo: todo,
            ),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: AddTodoScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
