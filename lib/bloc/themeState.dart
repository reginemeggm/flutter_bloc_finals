import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool? isDarkTheme;

  const ThemeState({this.isDarkTheme});

  ThemeState copyWith({bool? isDarkTheme}) {
    return ThemeState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  }

  Map<String, dynamic> toMap() => {'isDarkTheme': isDarkTheme};

  factory ThemeState.fromMap(Map<String, dynamic> map) =>
      ThemeState(isDarkTheme: map['isDarkTheme'] as bool);

  @override
  List<Object?> get props => [isDarkTheme];
}
