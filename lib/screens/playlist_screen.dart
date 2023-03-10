import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/data/data.dart';

import 'package:spotifly/models/models.dart';
import 'package:spotifly/providers/library_provider.dart';
import 'package:spotifly/widgets/widgets.dart';
import 'package:spotify_api/models/playlist.dart';

class PlaylistScreen extends StatefulWidget {
  static const routeName = '/playlist';
  final Playlist playlist;

  const PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollController;

  _loadInitial() async {
    await context.read<LibraryProvider>().loadPlaylist(widget.playlist.id);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.microtask(_loadInitial);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playlist = widget.playlist;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 140.0,
        leading: NavigationButtons(),
        actions: [ProfileMenu()],
      ),
      body: Container(
        width: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       const Color(0xFFAF1018),
        //       Theme.of(context).backgroundColor,
        //     ],
        //     stops: const [0, 0.3],
        //   ),
        // ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 0,
              floating: false,
              stretch: true,
              pinned: false,
              title: Text(playlist?.name ?? 'Loading'),
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 320),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: PlaylistHeader(playlist: playlist!),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red,
                      Theme.of(context).backgroundColor,
                    ],
                    stops: const [0, 1],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 12.0),
                child: _PlaylistTracks(),
              ),
            ),
            // SliverPadding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
            //   sliver: SliverTracksList(
            //     tracks: tracks,
            //   ),
            // )
          ],
        ),

        // child: Scrollbar(
        //   isAlwaysShown: true,
        //   controller: _scrollController,
        //   child: ListView(
        //     controller: _scrollController,
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 20.0,
        //       vertical: 60.0,
        //     ),
        //     children: [
        //       PlaylistHeader(playlist: widget.playlist),
        //       TracksList(tracks: widget.playlist.songs),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class _PlaylistTracks extends StatelessWidget {
  const _PlaylistTracks({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryProvider = context.watch<LibraryProvider>();

    if (libraryProvider.loading) {
      return Center(
        child: SizedBox(
          height: 2,
          child: LinearProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return TracksList(tracks: libraryProvider.currentTracks);
  }
}
