import 'package:flutter/material.dart';
import 'package:spotifly/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/providers/window_provider.dart';
import 'package:spotifly/widgets/widgets.dart';

class CurrentTrack extends StatelessWidget {
  const CurrentTrack({super.key});

  @override
  Widget build(BuildContext context) {
    final window = context.watch<WindowProvider>();
    return Container(
      height: window.isPinned ? 200 : 84.0,
      width: double.infinity,
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: window.isPinned
            ? Column(children: [
                _TrackInfo(),
                const Spacer(),
                _PlayerControls(),
                const Spacer(),
                _MoreControls(),
              ])
            : Row(children: [
                Expanded(child: _TrackInfo()),
                SizedBox(
                  width: 12,
                ),
                Expanded(child: _PlayerControls()),
                SizedBox(
                  width: 12,
                ),
                Expanded(child: _MoreControls()),
              ]),
      ),
    );
  }
}

class _TrackInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final window = context.watch<WindowProvider>();
    final track = player.selected;
    if (track == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment:
          window.isPinned ? MainAxisAlignment.center : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(
          track!.album.images.first.url,
          height: 60.0,
          width: 60.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              const SizedBox(height: 4.0),
              Text(
                track.artists.map((e) => e.name).join(', '),
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.grey[300], fontSize: 12.0),
              )
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        IconButton(
          iconSize: 16,
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
    final track = player.selected;
    if (track == null) return const SizedBox.shrink();
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.shuffle),
            iconSize: 20.0,
            onPressed: null,
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.skip_previous_outlined),
            iconSize: 20.0,
            onPressed: null,
          ),
          StreamBuilder(
              initialData: false,
              stream: player.isPlaying,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data!;
                return IconButton(
                  padding: const EdgeInsets.only(),
                  icon: Icon(isPlaying
                      ? Icons.pause_circle_outline
                      : Icons.play_circle),
                  iconSize: 34.0,
                  onPressed: () {
                    isPlaying
                        ? context.read<PlayerProvider>().pause()
                        : context.read<PlayerProvider>().resume();
                  },
                );
              }),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.skip_next_outlined),
            iconSize: 20.0,
            onPressed: null,
          ),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.repeat),
            iconSize: 20.0,
            onPressed: null,
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
    final window = context.watch<WindowProvider>();
    return Row(
      mainAxisAlignment:
          window.isPinned ? MainAxisAlignment.center : MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.devices_outlined),
          iconSize: 20.0,
          onPressed: () {},
        ),
        _VolumeControl(),
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
      mainAxisSize: MainAxisSize.max,
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
    // final maxWidth = MediaQuery.of(context).size.width * 0.3;
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 5.0,
              width: constraints.biggest.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            Container(
              height: 5.0,
              width: constraints.biggest.width * progress,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _VolumeControl extends StatelessWidget {
  const _VolumeControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
