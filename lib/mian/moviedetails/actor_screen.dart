import 'package:film_film/constants/dialog.show.image.dart';
import 'package:flutter/material.dart';
import 'package:service_movie/service_movie.dart';

class ActorScreen extends StatelessWidget {
  final PersonResponse personResponse;
  const ActorScreen({super.key, required this.personResponse});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              _PosterAndTitle(textTheme: textTheme, actor: personResponse),
              _OverView(textTheme: textTheme, actor: personResponse)
            ],
          ),
        )));
  }
}

class _PosterAndTitle extends StatelessWidget {
  final TextTheme textTheme;
  final PersonResponse actor;

  const _PosterAndTitle({
    Key? key,
    required this.actor,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: (){
             context.showDialogImage(actor.fullProfileImg);
          },
          child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(actor.fullProfileImg),
              width: 90,
              height: 140,
              fit: BoxFit.cover),
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              actor.name,
              style: textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Born in ${actor.formatBirthday}',
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              actor.placeOfBirth,
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              children: [
                const Icon(Icons.star_border_outlined,
                    size: 15, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  actor.popularity.toString(),
                  style: textTheme.bodySmall,
                )
              ],
            ),
            Chip(label: Text(actor.knownForDepartment))
          ],
        ),
      ),
    ]);
  }
}

class _OverView extends StatelessWidget {
  final PersonResponse actor;
  final TextTheme textTheme;
  const _OverView({Key? key, required this.textTheme, required this.actor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          actor.biography,
          style: textTheme.titleMedium,
          textAlign: TextAlign.justify,
        ));
  }
}
