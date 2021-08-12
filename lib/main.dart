import 'package:flutter/material.dart';
import 'package:samplebloccubit/presentation/router.dart';

void main() {
  final AppRouter router = AppRouter();
  // runApp(TodoApp(
  //   router: AppRouter(),
  // ));
  runApp(MaterialApp(
    onGenerateRoute: router.generateRoute,
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;

  const TodoApp({required Key key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
    );
  }
}
