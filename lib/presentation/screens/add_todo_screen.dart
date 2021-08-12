import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloccubit/cubit/add_todo_cubit.dart';
import 'package:samplebloccubit/cubit/add_todo_state.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
            return;
          } else if (state is AddTodoError) {
            print(state.error);
          }
        },
        child: Container(
          margin: EdgeInsets.all(20),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter todo message..."),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(),
        ),
      ],
    );
  }

  Widget _addBtn() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) return CircularProgressIndicator();

            return Text(
              "AddTodo",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
