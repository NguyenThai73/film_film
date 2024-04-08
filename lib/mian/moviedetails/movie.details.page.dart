import 'package:film_film/constants/dialog.show.image.dart';
import 'package:film_film/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_movie/service_movie.dart';

import 'casting_card.dart';
import 'movie.details.cutbit.dart';
import 'movie.details.cutbit.state.dart';
import 'video_slider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsCubitState>(
        builder: (context, state) {
          return state.status == Status.loading?
          Center(child: CircularProgressIndicator(color: Colors.blue,),)
          : CustomScrollView(
            slivers: [
              _CustomAppBar(movie: state.model),
              SliverList(
                  delegate: SliverChildListDelegate([
                _PosterAndTitle(state.model),
                _OverView(movie: state.model),
                CastingCard(),

                VideoSlider()
              ]))
            ],
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final MovieDetailsModel movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            color: Colors.black38,
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
            child: Text(
              movie.title ?? "",
              style: const TextStyle(fontSize: 19, color: Colors.white,),
            )),
        background:movie.backdrop_path!=null? FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage("$baseUrlImage${movie.backdrop_path}"),
          fit: BoxFit.cover,
        ):Container(color: Colors.grey,),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final MovieDetailsModel movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Hero(
          tag: movie.tagline ?? "",
          child: InkWell(
            onTap: (){
              context.showDialogImage("$baseUrlImage${movie.poster_path}");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:(movie.poster_path!=null && movie.poster_path != "")? FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage("$baseUrlImage${movie.poster_path}"),
                fit: BoxFit.cover,
                width: 100,
                height: 150,
              ):Container(color: Colors.grey,),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title ?? "",
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3),
              Text(movie.original_title ?? "",
                  maxLines: 3,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  const Icon(Icons.star_border_outlined,
                      size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    movie.vote_average.toString(),
                    style: textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class _OverView extends StatelessWidget {
  final MovieDetailsModel movie;
  const _OverView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movie.overview ?? "",
          style: textTheme.titleMedium, textAlign: TextAlign.justify),
    );
  }
}
