import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/cubit/edit_todo_cubit.dart';
import 'package:samplebloccubit/cubit/edit_todo_state.dart';
import 'package:samplebloccubit/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          print(state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Todo'),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            autocorrect: true,
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter todo message..."),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(onTap: () {
            BlocProvider.of<EditTodoCubit>(context).updateTodo(todo, _controller.text);
          }, child: _updateBtn()),
        ],
      ),
    );
  }

  Widget _updateBtn() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Update Todo",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
