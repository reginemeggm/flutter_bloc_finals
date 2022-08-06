import 'package:equatable/equatable.dart';

import '../models/task.dart';

class TaskState extends Equatable {
  final List<Task>? pendingTasks;
  final List<Task>? completedTasks;
  final List<Task>? removedTasks;
  final List<Task>? favoriteTasks;

  const TaskState({
    this.pendingTasks,
    this.completedTasks,
    this.removedTasks,
    this.favoriteTasks,
  });

  TaskState copyWith({
    List<Task>? pendingTasks,
    List<Task>? completedTasks,
    List<Task>? removedTasks,
    List<Task>? favoriteTasks,
  }) {
    return TaskState(
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      removedTasks: removedTasks ?? this.removedTasks,
      favoriteTasks: favoriteTasks ?? this.favoriteTasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks!.map((task) => task.toMap()).toList(),
      'completedTasks': completedTasks!.map((task) => task.toMap()).toList(),
      'removedTasks': removedTasks!.map((task) => task.toMap()).toList(),
      'favoriteTasks': favoriteTasks!.map((task) => task.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks:
      List.from(map['pendingTasks'].map((task) => Task.fromMap(task))),
      completedTasks:
      List.from(map['completedTasks'].map((task) => Task.fromMap(task))),
      removedTasks:
      List.from(map['removedTasks'].map((task) => Task.fromMap(task))),
      favoriteTasks:
      List.from(map['favoriteTasks'].map((task) => Task.fromMap(task))),
    );
  }

  @override
  List<Object?> get props => [
    pendingTasks,
    completedTasks,
    removedTasks,
    favoriteTasks,
  ];
}

