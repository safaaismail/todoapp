import 'package:flutertodoapp/db_helper.dart';
import 'package:flutertodoapp/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function function;
  Function function1;
  TaskWidget(this.task, [this.function1, this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Alert"),
                            content:
                                Text(" You Will Delete A task, are you sure?"),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    widget.function1(widget.task);
                                    Navigator.of(context).pop();
                                  }),
                              FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ]);
                      });
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  DBHelper.dbHelper.updateTask(Task(
                      widget.task.taskName,
                      this.widget.task.isComplete =
                          !this.widget.task.isComplete,
                      widget.task.id));
                  setState(() {});
                  widget.function();
                })
          ],
        ),
      ),
    );
  }
}
