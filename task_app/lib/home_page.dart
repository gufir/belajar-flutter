import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_app/models/task.dart';

class HomePage extends StatefulWidget{

  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();

  @override
  void initState() {
    super.initState();
    // Hive.initFlutter("box");
    // Hive.openBox('tasks');
  }

  @override
  Widget build(BuildContext context) {
    
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    print("Input value: $_newTaskContent");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
        "Task App",
        style: TextStyle(
          fontSize: 30,
        ),
        ),
      ),

      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'), 
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
      if (_snapshot.hasData) {
        _box = _snapshot.data;
        return _taskList();
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _taskList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length, 
      itemBuilder: (BuildContext __context, int _index ){
        var taskMap = tasks[_index];
        var task = Task.fromMap(taskMap);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
          ),
          subtitle: Text(
            task.timestamp.toString(),
          ),
          trailing: Icon(
            task.isDone 
            ? Icons.check_box_outlined 
            : Icons.check_box_outline_blank_outlined, 
            color: task.isDone ? Colors.green : Colors.red,
          ),

          onTap: () {
            task.isDone = !task.isDone;
            _box!.putAt(_index, task.toMap());
            setState(() {});
          },

          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {});
          },
        );
      },
    );
  } 

  Widget _addTaskButton() {
    return FloatingActionButton(onPressed: _displayTaskPopup, 
      child: const Icon(Icons.add),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    );
  }

  void _displayTaskPopup() {
    showDialog(context: context, builder: (BuildContext _context) {
      return AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          onSubmitted: (_){
            if (_newTaskContent != null) {
              var _task = Task(
                content: _newTaskContent!, 
              timestamp: DateTime.now(), 
              isDone: false);
              _box!.add(_task.toMap());
              setState(() {
                _newTaskContent = null;
                Navigator.pop(context);
              });
            }
          },
          onChanged: (_value) {
            setState(() {
              _newTaskContent = _value;
            });
          },
        ),
      );
    },
    );
  }

}