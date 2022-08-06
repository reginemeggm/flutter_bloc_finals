import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_finals/bloc/taskState.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CreateEditTask extends TaskEvent {
  final Task task;

  const CreateEditTask({required this.task});

  @override
  List<Object> get props => [task];
}

class AddToFavorite extends TaskEvent {
  final Task task;

  const AddToFavorite({required this.task});

  List<Object> get props => [task];
}

class CompleteTask extends TaskEvent {
  final Task task;

  const CompleteTask({required this.task});

  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});

  List<Object> get props => [task];
}

class RestoreTask extends TaskEvent {
  final Task task;

  const RestoreTask({required this.task});

  List<Object> get props => [task];
}

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc()
      : super(const TaskState(
    pendingTasks: [],
    completedTasks: [],
    removedTasks: [],
    favoriteTasks: [],
  )) {
    on<CreateEditTask>(addEditTask);
    on<AddToFavorite>(addToFavorite);
    on<CompleteTask>(completeTask);
    on<DeleteTask>(deleteTask);
    on<RestoreTask>(restoreTask);
  }

  void addEditTask(CreateEditTask event, Emitter<TaskState> emit) {
    int pendingIndex = state.pendingTasks!
        .indexWhere((element) => element.id == event.task.id);
    int completedIndex = state.completedTasks!
        .indexWhere((element) => element.id == event.task.id);

    if (pendingIndex == -1 && completedIndex == -1) {

      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)
              ..add(
                event.task.copyWith(
                  title: event.task.title,
                  description: event.task.description,
                ),
              )),
            completedTasks: state.completedTasks,
            favoriteTasks: state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    } else {

      int? favoriteIndex = state.favoriteTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: pendingIndex != -1
                ? (List.from(state.pendingTasks!)
              ..removeAt(pendingIndex)
              ..insert(
                pendingIndex,
                event.task.copyWith(
                  title: event.task.title,
                  description: event.task.description,
                ),
              ))
                : state.pendingTasks,
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
              ..removeAt(completedIndex)
              ..insert(
                completedIndex,
                event.task.copyWith(
                  title: event.task.title,
                  description: event.task.description,
                ),
              ))
                : state.completedTasks,
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
              ..removeAt(favoriteIndex)
              ..insert(
                favoriteIndex,
                event.task.copyWith(
                  title: event.task.title,
                  description: event.task.description,
                ),
              ))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    }
  }

  void addToFavorite(AddToFavorite event, Emitter<TaskState> emit) {
    int pendingIndex = state.pendingTasks!
        .indexWhere((element) => element.id == event.task.id);
    int completedIndex = state.completedTasks!
        .indexWhere((element) => element.id == event.task.id);

    if (!event.task.isFavorite!) {

      int? favoriteIndex = state.favoriteTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: pendingIndex == -1
                ? state.pendingTasks
                : (List.from(state.pendingTasks!)
              ..removeAt(pendingIndex)
              ..insert(
                  pendingIndex, event.task.copyWith(isFavorite: false))),
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
              ..removeAt(completedIndex)
              ..insert(
                  completedIndex, event.task.copyWith(isFavorite: false)))
                : state.completedTasks,
            favoriteTasks: (List.from(state.favoriteTasks!)
              ..removeAt(favoriteIndex)),
            removedTasks: state.removedTasks),
      );
    } else {

      emit(
        state.copyWith(
            pendingTasks: pendingIndex == -1
                ? state.pendingTasks
                : (List.from(state.pendingTasks!)
              ..removeAt(pendingIndex)
              ..insert(
                  pendingIndex, event.task.copyWith(isFavorite: true))),
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
              ..removeAt(completedIndex)
              ..insert(
                  completedIndex, event.task.copyWith(isFavorite: true)))
                : state.completedTasks,
            favoriteTasks: (List.from(state.favoriteTasks!)
              ..add(event.task.copyWith(isFavorite: true))),
            removedTasks: state.removedTasks),
      );
    }
  }

  void completeTask(CompleteTask event, Emitter<TaskState> emit) {
    int? favoriteIndex = state.favoriteTasks!
        .indexWhere((element) => element.id == event.task.id);

    if (!event.task.isDone!) {

      int completedIndex = state.completedTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)
              ..add(event.task.copyWith(isDone: false))),
            completedTasks: (List.from(state.completedTasks!)
              ..removeAt(completedIndex)),
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
              ..removeAt(favoriteIndex)
              ..insert(favoriteIndex, event.task.copyWith(isDone: false)))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    } else {

      int pendingIndex = state.pendingTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)
              ..removeAt(pendingIndex)),
            completedTasks: (List.from(state.completedTasks!)
              ..add(event.task.copyWith(isDone: true))),
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
              ..removeAt(favoriteIndex)
              ..insert(favoriteIndex, event.task.copyWith(isDone: true)))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    }
  }

  void deleteTask(DeleteTask event, Emitter<TaskState> emit) {
    if (!event.task.isDeleted!) {

      int removedIndex = state.removedTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: state.pendingTasks,
            completedTasks: state.completedTasks,
            favoriteTasks: state.favoriteTasks,
            removedTasks: List.from(state.removedTasks!)
              ..removeAt(removedIndex)),
      );
    } else {

      int pendingIndex = state.pendingTasks!
          .indexWhere((element) => element.id == event.task.id);
      int? favoriteIndex = state.favoriteTasks!
          .indexWhere((element) => element.id == event.task.id);
      int completedIndex = state.completedTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: pendingIndex != -1
                ? (List.from(state.pendingTasks!)..removeAt(pendingIndex))
                : state.pendingTasks,
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)..removeAt(completedIndex))
                : state.completedTasks,
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)..removeAt(favoriteIndex))
                : state.favoriteTasks,
            removedTasks: List.from(state.removedTasks!)
              ..add(event.task.copyWith(isDeleted: true))),
      );
    }
  }

  void restoreTask(RestoreTask event, Emitter<TaskState> emit) {
    int removedIndex = state.removedTasks!
        .indexWhere((element) => element.id == event.task.id);

    emit(state.copyWith(
      pendingTasks: !event.task.isDone!
          ? (List.from(state.pendingTasks!)
        ..add(event.task.copyWith(isDeleted: false)))
          : state.pendingTasks,
      completedTasks: event.task.isDone!
          ? (List.from(state.completedTasks!)
        ..add(event.task.copyWith(isDeleted: false)))
          : state.completedTasks,
      removedTasks: List.from(state.removedTasks!)..removeAt(removedIndex),
      favoriteTasks: event.task.isFavorite!
          ? (List.from(state.favoriteTasks!)
        ..add(event.task.copyWith(isDeleted: false)))
          : state.favoriteTasks,
    ));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
