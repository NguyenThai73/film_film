import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_film/main.dart';
import 'package:film_film/main.router.constant.dart';
import 'package:film_film/mian/viewmore/view.more.movie.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:go_router/go_router.dart';

import 'popula.cubit.dart';
import 'popula.cubit.state.dart';

class PopulaWidget extends StatefulWidget {
  const PopulaWidget({super.key});

  @override
  State<PopulaWidget> createState() => _PopulaWidgetState();
}

class _PopulaWidgetState extends State<PopulaWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopulaCubit, PopulaCubitState>(
      builder: (context, state) {
        return Column(
          children: [
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
                      "Popular",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF02406b),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  child: InkWell(
                    onTap: (){
                      context.push(MainRouterPath.routerViewMore, extra: TypeViewMore.popular);
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
            SizedBox(height: 5),
            (state.listMovie.isNotEmpty)
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: BackgrounBlurView(
                                imageUrl:
                                    state.listMovie[currentIndex].poster_path ??
                                        "")),
                        Positioned.fill(
                          child: Center(
                            child: Gallery3D(
                                controller: Gallery3DController(
                                    itemCount: state.listMovie.length),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                isClip: true,
                                onItemChanged: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                itemConfig: GalleryItemConfig(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  radius: 10,
                                  isShowTransformMask: false,
                                ),
                                onClickItem: (index) {
                                  context.push(
                                      MainRouterPath.routerMovieDetails,
                                      extra: state.listMovie[index]);
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$baseUrlImage${state.listMovie[index].poster_path ?? ""}",
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Color.fromARGB(
                                                255, 111, 130, 147),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.w700,
                                              shadows: [
                                                Shadow(
                                                    offset: Offset(-2, -2),
                                                    color: Color(0xFF02406b)),
                                                Shadow(
                                                    offset: Offset(2, -2),
                                                    color: Color(0xFF02406b)),
                                                Shadow(
                                                    offset: Offset(2, 2),
                                                    color: Color(0xFF02406b)),
                                                Shadow(
                                                    offset: Offset(-2, 2),
                                                    color: Color(0xFF02406b)),
                                              ]),
                                        ),
                                      ))
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(""),
                      )
                    ],
                  )
          ],
        );
      },
    );
  }
}

class BackgrounBlurView extends StatelessWidget {
  final String imageUrl;
  const BackgrounBlurView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            imageUrl: "$baseUrlImage$imageUrl",
            fit: BoxFit.cover,
          )),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            color: Colors.white.withOpacity(0.5),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
          ))
    ]);
  }
}
