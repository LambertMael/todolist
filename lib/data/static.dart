import 'package:todolist/models/task.dart';
import 'package:faker/faker.dart';
import 'dart:math';

List<Task> generateFakeTasks() {
  return List.generate(20, (int index) {
    var random = Random();
    final TaskStatus status =
        TaskStatus.values[random.nextInt(TaskStatus.values.length)];
    if (status == TaskStatus.done) {
      return Task(
          content: Faker().lorem.sentence(),
          status: status,
          completedAt: DateTime.now().add(Duration(
              days: random.nextInt(5),
              hours: random.nextInt(5),
              minutes: random.nextInt(5))));
    } else {
      return Task(content: Faker().lorem.sentence(), status: status);
    }
  });
}
