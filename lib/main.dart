import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'bloc/task_bloc.dart';
import 'cubit/theme_cubit.dart';
import 'app_router.dart';
import 'app_themes.dart';
import 'cubit/theme_state.dart';
import 'screens/tabs_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(appRouter: AppRouter())),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        final appTheme =
            state.isDarkTheme! ? AppTheme.darkMode : AppTheme.lightMode;
        return MaterialApp(
          title: 'BloC Tasks App',
          theme: AppThemes.appThemeData[appTheme],
          home: const TabsScreen(),
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      }),
    );
  }
}


