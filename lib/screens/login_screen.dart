import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/base/keys.dart';
import 'package:spotifly/base/routes.dart';
import 'package:spotifly/widgets/prompt_dialog.dart';
import 'package:spotify_api/spotify_api.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _LoginForm()));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final spotify = context.read<Spotify>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            spotify.openLogin();
            final result = await showDialog(
              context: context,
              builder: (context) {
                return const PromptDialog();
              },
            );

            if (result != null) {
              spotify.setAuthorization(result);
              AppKeys.navigatorKey.currentState!.pushNamed(Routes.library);
            }
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
