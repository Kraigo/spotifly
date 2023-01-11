import 'package:flutter/material.dart';
import 'package:spotifly/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/providers/window_provider.dart';
import 'package:spotifly/widgets/widgets.dart';

class CurrentTrack extends StatelessWidget {
  const CurrentTrack({super.key});

  @override
  Widget build(BuildContext context) {
    final isFull = (MediaQuery.of(context).size.width > 800);
    return Container(
      height: isFull ? 84.0 : 200,
      width: double.infinity,
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isFull
            ? Row(
                children: [
                  _TrackInfo(),
                  const Spacer(),
                  _PlayerControls(),
                  const Spacer(),
                  _MoreControls(),
                ],
              )
            : Column(
                children: [
                  _TrackInfo(),
                  const Spacer(),
                  _PlayerControls(),
                  const Spacer(),
                  _MoreControls(),
                ],
              ),
      ),
    );
  }
}

class _TrackInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final track = player.selected;
    if (track == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          track!.album.images.first.url,
          height: 60.0,
          width: 60.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 12.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              track.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 4.0),
            Text(
              track.artists.first.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.grey[300], fontSize: 12.0),
            )
          ],
        ),
        const SizedBox(width: 12.0),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final selected = player.selected;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.shuffle),
            iconSize: 20.0,
            onPressed: () {},
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.skip_previous_outlined),
            iconSize: 20.0,
            onPressed: () {},
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.play_circle_outline),
            iconSize: 34.0,
            onPressed: () {},
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.skip_next_outlined),
            iconSize: 20.0,
            onPressed: () {},
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.repeat),
            iconSize: 20.0,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 4.0),
      _ProgressIndicator()
    ]);
  }
}

class _MoreControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.devices_outlined),
          iconSize: 20.0,
          onPressed: () {},
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              onPressed: () {},
            ),
            Container(
              height: 5.0,
              width: 70.0,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.fullscreen_outlined),
          onPressed: () {
            if (context.read<WindowProvider>().isPinned) {
              context.read<WindowProvider>().unpin();
            } else {
              context.read<WindowProvider>().pin();
            }
          },
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
            initialData: const Duration(milliseconds: 0),
            stream: player.trackPosition,
            builder: (context, snapshot) {
              return TrackDuration(snapshot.data!,
                  style: Theme.of(context).textTheme.caption);
            }),
        const SizedBox(width: 8.0),
        StreamBuilder(
            initialData: const Duration(milliseconds: 0),
            stream: player.trackPosition,
            builder: (context, snapshot) {
              final current = snapshot.data?.inMilliseconds ?? 0;
              return StreamBuilder(
                  initialData: const Duration(milliseconds: 0),
                  stream: player.trackDuration,
                  builder: (context, snapshot) {
                    final total = snapshot.data?.inMilliseconds ?? 0;
                    double progress =
                        current > 0 && total > 0 ? (current / total) % 1 : 0;
                    return _ProgressLine(progress: progress);
                  });
            }),
        const SizedBox(width: 8.0),
        StreamBuilder(
            initialData: const Duration(milliseconds: 0),
            stream: player.trackDuration,
            builder: (context, snapshot) {
              return TrackDuration(snapshot.data!,
                  style: Theme.of(context).textTheme.caption);
            }),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final double progress;
  const _ProgressLine({
    required this.progress,
    super.key,
  }) : assert(progress >= 0 && progress <= 1,
            'Progress shoud be between 0 and 1');

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.3;
    return Stack(
      children: [
        Container(
          height: 5.0,
          width: maxWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        Container(
          height: 5.0,
          width: maxWidth * progress,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ],
    );
  }
}
