import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/providers/library_provider.dart';
import 'package:spotifly/widgets/widgets.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    Future.microtask(_loadInitial);
    super.initState();
  }

  _loadInitial() async {
    context.read<LibraryProvider>().loadPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Library")),
      // body: _buildList(),
      body: CustomScrollView(slivers: [_buildList()]),
    );
  }

  Widget _buildList() {
    final playlists = context.watch<LibraryProvider>().playlists;

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 254.0,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 180 / 254,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final playlist = playlists[index];
          return AlbumCard(
            name: playlist.name,
            imageUrl: playlist.images.first.url,
            description: playlist.description.isNotEmpty
                ? playlist.description
                : 'by ${playlist.owner.displayName}',
            onTap: () {},
          );
        },
        childCount: playlists.length,
      ),
    );

    return ListView.builder(
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Text(playlist.name);
      },
      itemCount: playlists.length,
    );
  }
}
