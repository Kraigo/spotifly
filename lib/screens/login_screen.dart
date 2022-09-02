import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotifly/widgets/prompt_dialog.dart';
import 'package:spotify_api/spotify_api.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Spotify spotify;
  @override
  void initState() {
    final clientId = dotenv.get('SPOTIFY_CLIENT_ID');
    final redirectUrl = dotenv.get('SPOTIFY_REDIRECT_URL');
    spotify = Spotify(clientId: clientId, redirectUrl: redirectUrl);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  getAccessToken();
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return PromptDialog();
                    },
                  );
                  

                  if (result != null) {
                    spotify.setAuthorization(result);
                  }
                },
                child: Text("login")),
            ElevatedButton(
                onPressed: () async {
                  final result = await spotify.playlists.getMyPlaylists();
                  debugPrint('result');
                },
                child: Text("get playlists")),
          ],
        ),
      ),
    );
  }

  Future getAccessToken() async {
    spotify.openLogin();
  }
}
