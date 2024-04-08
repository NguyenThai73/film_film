import 'package:film_film/mian/account/account.cubit.dart';
import 'package:film_film/mian/account/account.page.dart';
import 'package:film_film/mian/changepass/change.pass.cubit.dart';
import 'package:film_film/mian/login/login.cubit.dart';
import 'package:film_film/mian/login/login.page.dart';
import 'package:film_film/mian/register/register.cubit.dart';
import 'package:film_film/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_movie/service_movie.dart';
import 'package:service_user/service_user.dart';

import 'main.router.constant.dart';
import 'mian/changepass/change.pass.page.dart';
import 'mian/main.page.dart';
import 'mian/mian.cubit.dart';
import 'mian/moviedetails/movie.details.cutbit.dart';
import 'mian/moviedetails/movie.details.page.dart';
import 'mian/register/register.page.dart';
import 'mian/splash/splash.page.dart';
import 'mian/viewmore/view.more.movie.cubit.dart';
import 'mian/viewmore/view.more.movie.dart';
import 'repository/repository.movie.dart';

final router = GoRouter(
  observers: [MyNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
          create: (BuildContext context) => MainCubit(),
          child: const SplashPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerMain,
      builder: (context, state) => BlocProvider(
          create: (BuildContext context) => MainCubit(),
          child: const MainPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerLogin,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(
            authenticationRepository: context.read<AuthenticationRepository>()),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterCubit(
            authenticationRepository: context.read<AuthenticationRepository>()),
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerMovieDetails,
      builder: (context, state) {
        MovieModel movieModel = MovieModel();
        if (state.extra != null && state.extra is MovieModel) {
          movieModel = state.extra as MovieModel;
        }
        return BlocProvider(
            lazy: false,
            create: (BuildContext context) => MovieDetailsCubit(
                  repositoryMovie: context.read<RepositoryMovie>(),
                  movieModel: movieModel,
                ),
            child: const DetailsScreen());
      },
    ),
    GoRoute(
      path: MainRouterPath.routerViewMore,
      builder: (context, state) {
        return BlocProvider(
            lazy: false,
            create: (BuildContext context) => ViewMoreMovieCubit(
                  repositoryMovie: context.read<RepositoryMovie>(),
                  typeViewMore: state.extra as TypeViewMore,
                ),
            child: const ViewMore());
      },
    ),
    GoRoute(
      path: MainRouterPath.routerAccout,
      builder: (context, state) {
        return BlocProvider(
            create: (BuildContext context) => AccountCubit(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                  userModel:
                      context.read<AuthenticationRepository>().currentUser ??
                          UserModel(),
                ),
            child: const AccountPage());
      },
    ),
    GoRoute(
      path: MainRouterPath.routerChangePass,
      builder: (context, state) {
        return BlocProvider(
            create: (BuildContext context) => ChangePassCubit(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                ),
            child: const ChangePassPage());
      },
    ),
  ],
);

class MyNavigatorObserver extends NavigatorObserver {
  static var listRoute = <String>[];
  static final BehaviorSubject<String> currentRouter =
      BehaviorSubject<String>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.add(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPush route ${listRoute.join(',')}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPop route ${listRoute.join(',')}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didRemove route ${listRoute.join(',')}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    listRoute.remove(oldRoute?.settings.name ?? '');
    listRoute.add(newRoute?.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didReplace route ${listRoute.join(',')}');
  }
}

extension RouterMain on BuildContext {
  void popUntilPath(String routePath) {
    final router = GoRouter.of(this);
    while (router.location != routePath) {
      if (!router.canPop()) {
        return;
      }

      debugPrint('Popping ${router.location}');
      router.pop();
    }
  }
}
