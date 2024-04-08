import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_movie/service_movie.dart';

import '../../constants/list.load.state.dart';
import '../../main.router.constant.dart';
import 'view.more.movie.cubit.dart';

class ViewMore extends StatelessWidget {
  const ViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewMoreMovieCubit, ListLoadState<MovieModel>>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ))
              ],
            ),
            title: Center(
              child: Text(
                context.read<ViewMoreMovieCubit>().typeViewMore.namePage,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            actions: [
              SizedBox(width: 44),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color.fromARGB(255, 1, 52, 100),
                      Color(0xFF39e2ff)
                    ]),
              ),
            ),
          ),
          body: ListView.separated(
              controller: context.read<ViewMoreMovieCubit>().scrollController,
              itemCount: state.list.length,
              itemBuilder: (context, int index) {
                final movie = state.list[index];
                movie.heroId = 'search-${movie.id}';
                return ListTile(
                    leading: Hero(
                      tag: movie.heroId!,
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(movie.fullPosterImg),
                        fit: BoxFit.contain,
                        width: 60,
                      ),
                    ),
                    title: Text(movie.title ?? ""),
                    subtitle: Text(movie.original_title ?? ""),
                    onTap: () {
                      context.push(MainRouterPath.routerMovieDetails,
                          extra: movie);
                    });
              },
              separatorBuilder: (_, __) => const Divider()),
        );
      },
    );
  }
}
