import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_finals/bloc/themeState.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final bool isDarkTheme;

  const ToggleTheme({required this.isDarkTheme});

  List<Object> get props => [isDarkTheme];
}

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDarkTheme: false)) {
    on<ToggleTheme>((event, emit) {
      emit(state.copyWith(isDarkTheme: event.isDarkTheme));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
