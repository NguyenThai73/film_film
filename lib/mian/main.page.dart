// ignore_for_file: deprecated_member_use
import 'package:film_film/mian/chat/chat.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_user/service_user.dart';
import '../repository/authentication.repository.dart';
import '../repository/repository.movie.dart';
import 'chat/chat.cubit.dart';
import 'chat/list.chat.cubit.dart';
import 'drawer/drawer.page.dart';
import 'home/home.cubit.dart';
import 'home/home.page.dart';
import 'home/nowplaying/now.playing.cubit.dart';
import 'home/popular/popula.cubit.dart';
import 'home/toprated/top.rated.cubit.dart';
import 'home/upcoming/upcoming.cubit.dart';
import 'main.cubit.state.dart';
import 'mian.cubit.dart';
import 'search/srearch.screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              HomeCubit(repositoryMovie: context.read<RepositoryMovie>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              NowPlayingCubit(repositoryMovie: context.read<RepositoryMovie>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              PopulaCubit(repositoryMovie: context.read<RepositoryMovie>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              TopRatedCubit(repositoryMovie: context.read<RepositoryMovie>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              UpcomingCubit(repositoryMovie: context.read<RepositoryMovie>()),
        ),
        BlocProvider(
          create: (context) => ListChatCubit(
              userModel: context.read<AuthenticationRepository>().currentUser ??
                  UserModel()),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
           key: context.read<MainCubit>().key,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: const DrawerPage(),
          backgroundColor: Colors.white,
          body: BlocConsumer<MainCubit, MainCubitState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PageView(
                controller: context.read<MainCubit>().pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomePage(),
                  MoviesScreen(),
                  ChatPage(),
                ],
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<MainCubit, MainCubitState>(
            builder: (context, state) {
              return SalomonBottomBar(
                currentIndex: state.pageNumber,
                onTap: (index) => setState(() {
                  context.read<MainCubit>().selectBottomBar(page: index);
                }),
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                    selectedColor: Colors.blue,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: Icon(Icons.search),
                    title: Text("Search"),
                    selectedColor: Colors.blue,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: Icon(Icons.chat),
                    title: Text("Chat"),
                    selectedColor: Colors.blue,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
