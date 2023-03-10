import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotifly/base/keys.dart';
import 'package:spotifly/base/theme.dart';
import 'package:spotifly/providers/player_provider.dart';
import 'package:spotifly/providers/library_provider.dart';
import 'package:spotifly/providers/window_provider.dart';
import 'package:spotifly/screens/shell_screen.dart';
import 'package:provider/provider.dart';
import 'package:spotify_api/models/models.dart';
import 'package:spotify_api/spotify_api.dart';
import 'package:window_manager/window_manager.dart';

import 'base/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await dotenv.load(fileName: ".env");

  WindowOptions windowOptions = const WindowOptions(
    size: Size(900, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions);

  // if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
  //   await DesktopWindow.setMinWindowSize(const Size(600, 800));
  // }

  final spotify = Spotify(
      clientId: dotenv.get('SPOTIFY_CLIENT_ID'),
      redirectUrl: dotenv.get('SPOTIFY_REDIRECT_URL'));

  runApp(MultiProvider(
    providers: [
      Provider.value(
        value: spotify,
      ),
      ChangeNotifierProvider(
        create: (context) => PlayerProvider(spotify: Spotify.instance),
      ),
      ChangeNotifierProvider(
        create: (context) => LibraryProvider(spotify: Spotify.instance),
      ),
      ChangeNotifierProvider(
        create: (context) => WindowProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: appTheme,
      home: const ShellScreen(),
      // navigatorKey: AppKeys.navigatorKey,
      // initialRoute: '/login',
      // routes: {
      //   '/': (context) => const Shell(child: HomeScreen()),
      //   '/login': (context) => const LoginScreen()
      // }
    );
  }
}
