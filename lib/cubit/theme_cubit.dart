import 'package:flutter_bloc_finals/cubit/theme_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> with HydratedMixin {
  ThemeCubit() : super(const ThemeState(isDarkTheme: false));

  void toggleTheme(bool isDarkTheme) {
    emit(state.copyWith(isDarkTheme: isDarkTheme));
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