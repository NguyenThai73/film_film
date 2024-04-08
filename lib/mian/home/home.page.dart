// ignore_for_file: use_build_context_synchronously
import 'package:film_film/constants/component/loading/loading.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/appbar.dart';
import 'home.cubit.dart';
import 'home.cubit.state.dart';
import 'nowplaying/now.playing.dart';
import 'popular/popula.page.dart';
import 'toprated/top.rated.dart';
import 'upcoming/upcoming.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeCubit, HomeCubitState>(
      listener: (context, state) {
        if (state.status == HomeStatus.loading) {
          context.read<LoadingCubit>().makeLoading();
        } else {
          context.read<LoadingCubit>().makeNoneLoading();
        }
      },
      builder: (context, state) {
        return AppbarCustom(
          titilePage: "Movie Page",
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),
                PopulaWidget(),
                NowPlayingWidget(),
                TopRatedWidget(),
                UpcomingWidget(),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
