import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String? createdAt;
  final bool? isDone;
  final bool? isDeleted;
  final bool? isFavorite;

  Task({
    id,
    required this.title,
    required this.description,
    createdAt,
    isDone,
    isDeleted,
    isFavorite,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now().toString(),
        isDone = isDone ?? false,
        isDeleted = isDeleted ?? false,
        isFavorite = isFavorite ?? false;

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? createdAt,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        isDone,
        isDeleted,
        isFavorite,
      ];
}
