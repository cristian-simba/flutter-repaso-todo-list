import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_list.dart';

class TodoListProvider with ChangeNotifier {
  List<TodoList> _todoList = [
    TodoList(id: "0", title: "Aaa", subtitle: "XD", isComplete: false),
  ];

  int _counter = 1;

  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }

  List<TodoList> get todoList => _todoList;

  void addTodoList(TodoList todoList) {
    _todoList.add(todoList);
    notifyListeners();
  }

  void updateList(String id, TodoList updateTodoList) {
    int index = _todoList.indexWhere((todoList) => todoList.id == id);
    if (index != -1) {
      _todoList[index] = updateTodoList;
      notifyListeners();
    }
  }

  void deleteList(String id) {
    _todoList.removeWhere((todoList) => todoList.id == id);
    notifyListeners();
  }

  void toggleComplete(TodoList todoList) {
    int index = _todoList.indexWhere((item) => item.id == todoList.id);
    if (index != -1) {
      _todoList[index].isComplete = !_todoList[index].isComplete;
      notifyListeners();
    }
  }
}
