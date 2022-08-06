import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_finals/bloc/task_state.dart';
import 'package:flutter_bloc_finals/models/task.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
    int? favoriteIndex = state.favoriteTasks!
        .indexWhere((element) => element.id == event.task.id);

    if (pendingIndex == -1 && completedIndex == -1) {
      // If Adding Task
      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)..add(event.task)),
            completedTasks: state.completedTasks,
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
                  ..removeAt(favoriteIndex)
                  ..insert(favoriteIndex, event.task))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    } else {
      // If Editing Task
      emit(
        state.copyWith(
            pendingTasks: pendingIndex != -1
                ? (List.from(state.pendingTasks!)
                  ..removeAt(pendingIndex)
                  ..insert(pendingIndex, event.task))
                : state.pendingTasks,
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
                  ..removeAt(completedIndex)
                  ..insert(completedIndex, event.task))
                : state.completedTasks,
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
                  ..removeAt(favoriteIndex)
                  ..insert(favoriteIndex, event.task))
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
      // Toggle from Favorite to Unfavorite
      int? favoriteIndex = state.favoriteTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: pendingIndex == -1
                ? state.pendingTasks
                : (List.from(state.pendingTasks!)
                  ..removeAt(pendingIndex)
                  ..insert(pendingIndex, event.task)),
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
                  ..removeAt(completedIndex)
                  ..insert(completedIndex, event.task))
                : state.completedTasks,
            favoriteTasks: (List.from(state.favoriteTasks!)
              ..removeAt(favoriteIndex)),
            removedTasks: state.removedTasks),
      );
    } else {
      // Toggle from Unfavorite to Favorite
      emit(
        state.copyWith(
            pendingTasks: pendingIndex == -1
                ? state.pendingTasks
                : (List.from(state.pendingTasks!)
                  ..removeAt(pendingIndex)
                  ..insert(pendingIndex, event.task)),
            completedTasks: completedIndex != -1
                ? (List.from(state.completedTasks!)
                  ..removeAt(completedIndex)
                  ..insert(completedIndex, event.task))
                : state.completedTasks,
            favoriteTasks: (List.from(state.favoriteTasks!)..add(event.task)),
            removedTasks: state.removedTasks),
      );
    }
  }

  void completeTask(CompleteTask event, Emitter<TaskState> emit) {
    int? favoriteIndex = state.favoriteTasks!
        .indexWhere((element) => element.id == event.task.id);

    if (!event.task.isDone!) {
      // Toggle from Complete to Incomplete
      int completedIndex = state.completedTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)..add(event.task)),
            completedTasks: (List.from(state.completedTasks!)
              ..removeAt(completedIndex)),
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
                  ..removeAt(favoriteIndex)
                  ..insert(favoriteIndex, event.task))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    } else {
      // Toggle from Incomplete to Complete
      int pendingIndex = state.pendingTasks!
          .indexWhere((element) => element.id == event.task.id);
      emit(
        state.copyWith(
            pendingTasks: (List.from(state.pendingTasks!)
              ..removeAt(pendingIndex)),
            completedTasks: (List.from(state.completedTasks!)..add(event.task)),
            favoriteTasks: favoriteIndex != -1
                ? (List.from(state.favoriteTasks!)
                  ..removeAt(favoriteIndex)
                  ..insert(favoriteIndex, event.task))
                : state.favoriteTasks,
            removedTasks: state.removedTasks),
      );
    }
  }

  void deleteTask(DeleteTask event, Emitter<TaskState> emit) {
    if (!event.task.isDeleted!) {
      // Delete Forever
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
      // Delete to Recycle Bin
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
            removedTasks: List.from(state.removedTasks!)..add(event.task)),
      );
    }
  }

  void restoreTask(RestoreTask event, Emitter<TaskState> emit) {
    int removedIndex = state.removedTasks!
        .indexWhere((element) => element.id == event.task.id);

    emit(state.copyWith(
      pendingTasks: !event.task.isDone!
          ? (List.from(state.pendingTasks!)..add(event.task))
          : state.pendingTasks,
      completedTasks: event.task.isDone!
          ? (List.from(state.completedTasks!)..add(event.task))
          : state.completedTasks,
      removedTasks: List.from(state.removedTasks!)..removeAt(removedIndex),
      favoriteTasks: event.task.isFavorite!
          ? (List.from(state.favoriteTasks!)..add(event.task))
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