import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_film/mian/home/upcoming/upcoming.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../../main.router.constant.dart';
import '../../viewmore/view.more.movie.cubit.dart';
import 'upcoming.cubit.state.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({super.key});

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingCubit, UpcomingCubitState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 40,
                      width: 10,
                      decoration: BoxDecoration(color: Color(0xFF02406b)),
                    ),
                    Text(
                      "Upcoming",
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF02406b),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  child: InkWell(
                    onTap: () {
                      context.push(MainRouterPath.routerViewMore,
                          extra: TypeViewMore.upcoming);
                    },
                    child: Text(
                      "View more",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          color: Colors.blue,
                          fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller:
                          context.read<UpcomingCubit>().scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listMovie.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              context.push(MainRouterPath.routerMovieDetails,
                                  extra: state.listMovie[index]);
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  "$baseUrlImage${state.listMovie[index].poster_path ?? ""}",
                              fit: BoxFit.fill,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: imageProvider)),
                                );
                              },
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 111, 130, 147),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
