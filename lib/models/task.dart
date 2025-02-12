import 'package:uuid/uuid.dart';

class Task{
  String content;
  String? id;
  DateTime? createdAt;
  DateTime? completedAt;
  TaskStatus status;

  Task({required this.content,this.status = TaskStatus.todo, this.createdAt, this.completedAt, this.id}){
    id = id ?? Uuid().v4();
    createdAt = createdAt ?? DateTime.now();
  }

  Task.fromValues({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.status,
    this.completedAt
  });


  @override
  String toString(){
    return "Task (id: $id, content: $content, status: $status, createdAt: $createdAt, completedAt: $completedAt)";
  }

}

enum TaskStatus {
  todo,
  doing,
  done
}

