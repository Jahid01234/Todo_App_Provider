import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_provider/model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
    List<TodoModel> _todoList = [];
    List<TodoModel> get allTodoList => _todoList;

   // add to-do item
    void addTodo(TodoModel todoModel){
      _todoList.add(todoModel);
      saveTodos();
      // for updated
      notifyListeners();
    }

   // deleted to-do item
   void deleteTodo(TodoModel todoModel){
      _todoList.remove(todoModel);
      saveTodos();
      notifyListeners();
   }

   // change complete or not
   void todoStatusChange(TodoModel todoModel){
      todoModel.isCompleted = !todoModel.isCompleted;
      saveTodos();
      notifyListeners();
   }

    // Save todos to shared_preferences
    Future<void> saveTodos() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> todoListString = _todoList.map((todo) => jsonEncode(todo.toJson())).toList();
      await prefs.setStringList('todoList', todoListString);
    }

    // Load todos from shared_preferences
    Future<void> loadTodos() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? todoListString = prefs.getStringList('todoList');
      if (todoListString != null) {
        _todoList = todoListString.map((todo) => TodoModel.fromJson(jsonDecode(todo))).toList();
      }
      notifyListeners(); // Notify listeners after loading data
    }

}