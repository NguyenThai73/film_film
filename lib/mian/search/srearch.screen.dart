import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/avar.dart';
import '../home/nowplaying/now.playing.cubit.dart';
import '../home/nowplaying/now.playing.cubit.state.dart';
import '../home/popular/popula.cubit.dart';
import '../home/popular/popula.cubit.state.dart';
import 'card_swiper.dart';
import 'movie_slider.dart';
import 'search_delegate.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [SizedBox(width: 10), AvartarApp()],
          ),
          title: Center(
            child: Text(
              "Search Page",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                showSearch(context: context, delegate: MovieSearchDelegate());
              },
            ),
            SizedBox(width: 10),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/appbar.jpg"), fit: BoxFit.cover)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // Slider principal
            BlocBuilder<NowPlayingCubit, NowPlayingCubitState>(
              builder: (context, state) {
                return CardSwiper(movies: state.listMovie);
              },
            ),

            // Slider de peliculas
            BlocBuilder<PopulaCubit, PopulaCubitState>(
              builder: (context, state) {
                return MovieSlider(
                  movies: state.listMovie,
                  title: 'Popular',
                  onNextPage: () {},
                );
              },
            ),
          ]),
        ));
  }
}
