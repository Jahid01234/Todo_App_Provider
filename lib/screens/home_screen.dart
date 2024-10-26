import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/provider/todo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputTextController = TextEditingController();

   @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().loadTodos();
  }

  @override
  Widget build(BuildContext context) {
     // create TodoProvider class instance
     final provider = Provider.of<TodoProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: const Color(0xff34495e),
        backgroundColor: const Color(0xff34495e),
        centerTitle: true,
        title: const Text("Todo List",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: provider.allTodoList.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        onTap: (){
                          provider.todoStatusChange(provider.allTodoList[index]);
                        },
                        leading: MSHCheckbox(
                            size: 23,
                            style: MSHCheckboxStyle.stroke,
                            colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Colors.blueGrey,
                            ),
                            value: provider.allTodoList[index].isCompleted,
                            onChanged: (value){
                               provider.todoStatusChange(provider.allTodoList[index]);
                            },
                        ),
                        title:  Wrap(
                          children: [
                            Text(
                                provider.allTodoList[index].title,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.cyan.shade800,
                                    fontWeight: FontWeight.w600,
                                    decoration: provider.allTodoList[index].isCompleted==true
                                        ? TextDecoration.lineThrough
                                        : null,
                                  letterSpacing: 0.5,
                                  wordSpacing: 2,
                                ),
                            ),
                          ]
                        ),
                        trailing: IconButton(
                            onPressed: (){
                             provider.deleteTodo(provider.allTodoList[index]);
                            },
                            icon: const Icon(Icons.delete,color: Colors.blueGrey ,),
                        ),
                      );
                    },
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff34495e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: (){
          _showDialogBox();
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  // show dialog box
  Future<void> _showDialogBox()async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(
            child: Text(
              "Add todo",
              style: TextStyle(
                color: Color(0xff34495e),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: TextField(
            controller: _inputTextController,
            decoration: const InputDecoration(
              hintText: "Write todo.",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _inputTextController.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async{
                if (_inputTextController.text.isEmpty) {
                  return;
                }

                context.read<TodoProvider>().addTodo(
                  TodoModel(
                    title: _inputTextController.text,
                    isCompleted: false,
                  ),
                );
                _inputTextController.clear();
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
