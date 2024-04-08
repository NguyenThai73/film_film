import 'package:film_film/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/component/error/error.wrapper.dart';
import 'constants/component/loading/loading.wrapper.dart';
import 'main.router.dart';
import 'mian/authentication/authentication.bloc.dart';
import 'mian/cubit/user.change.cubit.dart';
import 'repository/authentication.repository.dart';
import 'repository/repository.movie.dart';

// import 'package:service_movie/service_movie.dart';
String baseUrlImage = "https://image.tmdb.org/t/p/original/";
final GlobalKey<ScaffoldState> myKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RepositoryMovie repositoryMovie;
  final AuthenticationRepository authenticationRepository;

  MyApp({super.key})
      : repositoryMovie = RepositoryMovie(),
        authenticationRepository = AuthenticationRepository();
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: repositoryMovie),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider(
              create: (_) => UserChangeCubit(authenticationRepository)),
        ],
        child: ErrorWrapper(
          child: LoadingWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  navigationBarTheme: const NavigationBarThemeData(
                      backgroundColor: Colors.white)),
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
