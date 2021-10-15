
import 'package:flutter/cupertino.dart';
import 'package:habits_ui/todo_model.dart';

class TodoProvider extends ChangeNotifier {

  // GENERATING DEFAULT LIST OF TODOS
  List<ToDo> todos = List.generate(30, (index) => ToDo(index.toString(), '', 0.0, false));





}