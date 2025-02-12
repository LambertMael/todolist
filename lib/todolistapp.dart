import 'package:flutter/material.dart';
import 'package:todolist/data/static.dart';
import 'package:todolist/models/task.dart';

final ThemeData toDoListTheme = ThemeData(
  primaryColor: toDoListThemeMainColor,
);
final Color toDoListThemeMainColor = Colors.deepPurpleAccent;

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  late List<Task> _tasks;
    late List<Task> _tmpTasks;

  @override
  void initState() {
    //final List<Task> initialTasks = generateFakeTasks().where((Task task)=>task.status==TaskStatus.done).toList();
    final List<Task> initialTasks = generateFakeTasks();
    _tasks = initialTasks;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Icon buildIcon(TaskStatus ts) {
      switch (ts) {
        case TaskStatus.todo:
          return Icon(Icons.watch_later, color: Colors.yellow);
        case TaskStatus.doing:
          return Icon(Icons.loop, color: Colors.deepOrange);
        case TaskStatus.done:
          return Icon(Icons.task_alt, color: Colors.green);
      }
    }

    TextStyle buildTextStyle(TaskStatus ts){
      switch (ts) {
        case TaskStatus.done:
          return TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.green,
                  fontSize: 12,
          );
        default:
          return TextStyle(
                  fontSize: 12,
          );
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: toDoListTheme,
      home: Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Todolist",
                style: TextStyle(
                  color: toDoListThemeMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                  decorationColor: toDoListThemeMainColor,
                )),
            Text('${_tasks.length} Tasks',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ))
          ]),
          leading: Image.asset("images/todolist.png"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final Task currentTask = _tasks[index];

                    return ListTile(
                      title: Text(currentTask.content, style: buildTextStyle(currentTask.status)),
                      trailing: buildIcon(currentTask.status) ,
                      leading: Checkbox(
                          value: (currentTask.completedAt != null),
                          onChanged: (value) {
                            setState(() {
                              currentTask.status =
                                  currentTask.status == TaskStatus.done
                                      ? TaskStatus.todo
                                      : TaskStatus.done;
                              currentTask.completedAt =
                                  currentTask.status == TaskStatus.done
                                      ? DateTime.now()
                                      : null;
                            });
                          }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
