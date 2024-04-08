import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../main.router.constant.dart';
import '../../repository/repository.movie.dart';
import 'search.cubit.dart';
import 'search.cubit.state.dart';

class MovieSearchDelegate extends SearchDelegate {
  final SearchCubit searchCubit =
      SearchCubit(repositoryMovie: RepositoryMovie());
  MovieSearchDelegate();

  @override
  String get searchFieldLabel => 'Search';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyResults();
    } else {
      searchCubit.getData(findName: query);
    }

    return BlocProvider.value(
      value: searchCubit,
      child: BlocBuilder<SearchCubit, SearchCubitState>(
        builder: (context, state) {
          return ListView.separated(
            controller: context.read<SearchCubit>().scrollController,
              itemCount: state.listMovie.length,
              itemBuilder: (context, int index) {
                final movie = state.listMovie[index];
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
              separatorBuilder: (_, __) => const Divider());
        },
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image(image: AssetImage('assets/empty.png'))),
        SizedBox(height: 10),
        Text(
          'No movie',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
