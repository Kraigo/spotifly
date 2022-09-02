import 'package:flutter/material.dart';
import 'package:spotifly/models/models.dart';
import 'package:spotify_api/models/playlist.dart';

class PlaylistHeader extends StatelessWidget {
  final Playlist playlist;

  const PlaylistHeader({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              playlist.images.first.url,
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PUBLIC PLAYLIST',
                    style: theme.textTheme.overline!,
                  ),
                  const SizedBox(height: 12.0),
                  Text(playlist.name, style: theme.textTheme.headline2, maxLines: 2,overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 16.0),
                  Text(
                    playlist.description,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: theme.textTheme.caption!.color),
                  ),
                  const SizedBox(height: 16.0),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: playlist.owner.displayName,
                        style: theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.headline2!.color)),
                    TextSpan(text: ' • '),
                    TextSpan(
                        text: '1000 likes',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: theme.textTheme.headline2!.color)),
                    TextSpan(text: ' • '),
                    TextSpan(
                        text: '1000 songs',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: theme.textTheme.headline2!.color)),
                    TextSpan(
                        text: ', 1000',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: theme.textTheme.caption!.color))
                  ])),
                  // Text(
                  //   'Created by ${playlist.creator} • ${playlist.songs.length} songs, ${playlist.duration}',
                  //   style: theme.textTheme.subtitle1,
                  // ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        _PlaylistButtons(followers: 'asd'),
      ],
    );
  }
}

class _PlaylistButtons extends StatelessWidget {
  final String followers;

  const _PlaylistButtons({
    Key? key,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 48.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            primary: Theme.of(context).iconTheme.color,
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontSize: 12.0, letterSpacing: 2.0),
          ),
          onPressed: () {},
          child: const Text('PLAY'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          iconSize: 30.0,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          iconSize: 30.0,
          onPressed: () {},
        ),
        const Spacer(),
        Text(
          'FOLLOWERS\n$followers',
          style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
