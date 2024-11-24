import 'package:flutter/material.dart';
import 'package:todo_list/providers/todo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_list.dart';

class IncompleteList extends StatefulWidget {
  const IncompleteList({ Key? key }) : super(key: key);

  @override
  _IncompleteListState createState() => _IncompleteListState();
}

class _IncompleteListState extends State<IncompleteList> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _editSubtitleController = TextEditingController();

  void updateList(TodoList list){
    _editTitleController.text = list.title;
    _editSubtitleController.text = list.subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TodoListProvider>(
        builder: (context, todoListProvider, child) {
          final inCompleteTasks = todoListProvider.todoList.where((todoList) => !todoList.isComplete).toList();
          return ListView.builder(
            itemCount: inCompleteTasks.length,
            itemBuilder: (context, index) {
              TodoList todoList = inCompleteTasks[index];
              return ListTile(
                title: Text(todoList.id.toString() + " " + todoList.title),
                subtitle: Text(todoList.subtitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: todoList.isComplete, 
                      onChanged: (bool ?value){
                        todoListProvider.toggleComplete(todoList);
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tarea Completa"))
                      );
                      }
                    ),
                    IconButton(
                      onPressed: (){
                        todoListProvider.deleteList(todoList.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tarea Eliminada"))
                        );
                      }, 
                      icon: Icon(Icons.delete)
                    ),
                    IconButton(
                      onPressed: (){
                        updateList(todoList);
                        showDialog(
                          context: context, 
                          builder: (context){
                            return AlertDialog(
                              title: Text("Editar Usuario"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _editTitleController,
                                    decoration: InputDecoration(label: Text("Titulo")),
                                  ),
                                  TextField(
                                    controller: _editSubtitleController,
                                    decoration: InputDecoration(label: Text("Descripcion")),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Provider.of<TodoListProvider>(context, listen: false).updateList(
                                      todoList.id, 
                                      TodoList(
                                        id: todoList.id,
                                        title: _editTitleController.text, 
                                        subtitle: _editSubtitleController.text
                                      )
                                    );
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("Actualizar tarea")
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("Cancelar")
                                )
                              ],
                            );
                          }
                        );
                      },
                      icon: Icon(Icons.edit),
                    )
                  ],
                )
              );
            },
          );
        },
      ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("Agregar Tarea"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(label: Text("Titulo")),
                    ),
                    TextField(
                      controller: _subtitleController,
                      decoration: InputDecoration(label: Text("Descripcion")),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Provider.of<TodoListProvider>(context, listen: false).addTodoList(
                        TodoList(
                          id: Provider.of<TodoListProvider>(context, listen: false).counter.toString(),
                          title: _titleController.text, 
                          subtitle: _subtitleController.text,
                          isComplete: false,
                        )
                      );
                      Provider.of<TodoListProvider>(context, listen: false).increment();
                      Navigator.pop(context);
                      _titleController.text = "";
                      _subtitleController.text = "";
                    }, 
                    child: Text("Agregar Tarea")
                  ),
                  TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancelar")
                  )
                ],
              );
            }
          );
        },
        backgroundColor: Colors.grey.shade900,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}