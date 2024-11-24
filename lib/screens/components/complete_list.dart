import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_list.dart';
import 'package:todo_list/providers/todo_list_provider.dart';

class CompleteList extends StatefulWidget {
  const CompleteList({Key? key}) : super(key: key);

  @override
  _CompleteListState createState() => _CompleteListState();
}

class _CompleteListState extends State<CompleteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas Completas', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, todoListProvider, child) {
          final completeTasks = todoListProvider.todoList.where((todoList) => todoList.isComplete).toList();
          return ListView.builder(
            itemCount: completeTasks.length,
            itemBuilder: (context, index) {
              TodoList todoList = completeTasks[index];
              return ListTile(
                title: Text(todoList.id.toString() + " " + todoList.title),
                subtitle: Text(todoList.subtitle),
                trailing: Checkbox(
                  value: todoList.isComplete,
                  onChanged: (bool? value) {
                    setState(() {
                      todoListProvider.toggleComplete(todoList);
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
