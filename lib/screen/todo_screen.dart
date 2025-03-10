import 'package:flutter/material.dart';
import 'package:workshop_task/models/todo.dart';
import 'package:workshop_task/models/todo_list.dart';
import 'package:workshop_task/widgets/add_todo_dialogue.dart';
import 'package:workshop_task/widgets/todo_list_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController desccontroller = TextEditingController();

  TodoList doList = TodoList();
  Widget wigbody = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Center(
        child: Text("No Todos Added"),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Todos"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddTodoDialogue();
                  }).then((value) {
                setState(() {
                  {
                    doList.addTodo(value);
                  }
                });
              });
            }),
        body: doList.allTodos().isEmpty
            ? wigbody
            : ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text(
                                  "Are you sure you want to delete this todo"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Todo content = doList.allTodos()[index];
                                      Navigator.pop(context, content);
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"))
                              ],
                            );
                          }).then((value) {
                        setState(() {
                          doList.deleteTodo(value);
                        });
                      });
                    },
                    child: TodoListItem(
                      index: index + 1,
                      todo: doList.allTodos()[index],
                    ),
                  );
                },
                itemCount: doList.allTodos().length,
              ));
  }
}
