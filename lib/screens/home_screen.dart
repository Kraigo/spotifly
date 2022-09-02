import 'package:flutter/material.dart';
import 'package:spotifly/base/keys.dart';
import 'package:spotifly/base/routes.dart';
import 'package:spotifly/data/data.dart';
import 'package:spotifly/models/models.dart';
import 'package:spotifly/screens/playlist_screen.dart';
import 'package:spotifly/widgets/widgets.dart';
import 'package:spotify_api/models/playlist.dart';
import 'package:spotify_api/spotify_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          // title: Text("Title"),
          // expandedHeight: 30.0,
          pinned: true,
          backgroundColor: Colors.transparent,
          actions: [ProfileMenu()],
        ),
        // const SliverToBoxAdapter(
        //     child: _HorizontalSection(
        //   title: 'Jump Back',
        //   playlists: homePlaylists,
        // )),
        // const SliverToBoxAdapter(
        //     child: _HorizontalSection(
        //   title: 'Recently Played',
        //   playlists: homePlaylists,
        // )),
        // const SliverToBoxAdapter(
        //     child: _HorizontalSection(
        //   title: 'Made for your',
        //   playlists: homePlaylists,
        // )),
      ],
    ));
  }
}

class _HorizontalSection extends StatelessWidget {
  final String title;
  final List<Playlist> playlists;
  const _HorizontalSection({
    required this.title,
    required this.playlists,
    super.key,
  });

  void _openPlaylist(context, Playlist playlist) {
    Navigator.of(context).pushNamed(
      Routes.playlist,
      arguments: {'playlist': playlist}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.0, bottom: 12.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 254,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return Container();
              // return AlbumCard(
              //   name: playlist.name,
              //   description: playlist.description,
              //   imageUrl: playlist.imageURL,
              //   color: Color(int.parse(playlist.color)),
              //   onTap: () {_openPlaylist(context, playlist);}
              // );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
          ),
        ),
      ],
    );
  }
}
