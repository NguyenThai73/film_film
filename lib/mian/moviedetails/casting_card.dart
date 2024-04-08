// ignore_for_file: use_build_context_synchronously

import 'package:film_film/constants/component/loading/loading.cubit.dart';
import 'package:film_film/mian/moviedetails/actor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_movie/service_movie.dart';

import 'movie.details.cutbit.dart';
import 'movie.details.cutbit.state.dart';

class CastingCard extends StatelessWidget {
  const CastingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsCubitState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          height: 190,
          child: ListView.builder(
              itemCount: state.listCast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(state.listCast[index])),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              context.read<LoadingCubit>().makeLoading();
              var persion = await context
                  .read<MovieDetailsCubit>()
                  .repositoryMovie
                  .getPersonResponse(idPersion: actor.id);
              context.read<LoadingCubit>().makeNoneLoading();
              if (persion != null) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ActorScreen(
                      personResponse: persion,
                    ),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(actor.fullProfileImg),
                  width: 90,
                  height: 140,
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${actor.name} (${actor.character})',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
