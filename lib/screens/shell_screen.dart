import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/base/keys.dart';
import 'package:spotifly/base/routes.dart';

import 'package:spotifly/providers/window_provider.dart';
import 'package:spotifly/widgets/widgets.dart';
import 'package:spotify_api/models/models.dart';
import 'package:spotify_api/spotify_api.dart';
import 'package:window_manager/window_manager.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    final spotify = context.read<Spotify>();

    spotify.httpClient.onEvent.listen(
      (event) {
        switch (event.type) {
          case CloudEventType.authorizationFailed:
            AppKeys.navigatorKey.currentState?.pushNamed(Routes.login);
            break;
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMoved() async {
    if (await windowManager.isAlwaysOnTop()) return;
    context.read<WindowProvider>().updateCurrentState();
  }

  @override
  void onWindowResize() async {
    if (await windowManager.isAlwaysOnTop()) return;
    context.read<WindowProvider>().updateCurrentState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (!context.watch<WindowProvider>().isPinned)
            Expanded(
              child: Row(
                children: [
                  if (MediaQuery.of(context).size.width > 800) SideMenu(),
                  Expanded(child: ClipRect(child: _buildRouterView()))
                ],
              ),
            ),
          CurrentTrack(),
        ],
      ),
    );
  }

  Widget _buildRouterView() {
    return WillPopScope(
        onWillPop: () async =>
            !await AppKeys.navigatorKey.currentState!.maybePop(),
        child: Navigator(
          initialRoute: '/library',
          key: AppKeys.navigatorKey,
          onGenerateRoute: Routes.onGenerateRoute,
        ));
  }
}
