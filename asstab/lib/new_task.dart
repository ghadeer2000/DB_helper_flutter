import 'package:asstab/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DBHelper.dart';


class NewTasks extends StatefulWidget {
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  int id;
  bool isComplete = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("Enter Task"))
            ,
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
              value: isComplete,
              onChanged: (value) {
                this.isComplete = value;
                setState(() {});
              },
            ),
            RaisedButton(
                child: Text('add Task'),
                onPressed: () {
                  DBhelper.dbHelper.insertNewTask(
                      Task(this.taskName, this.isComplete, this.id));
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

