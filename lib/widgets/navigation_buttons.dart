import 'package:flutter/material.dart';

import 'widgets.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleButton(
              icon: Icons.chevron_left,
              onTap: () {
                Navigator.of(context).pop();
              }),
          const SizedBox(width: 16.0),
          CircleButton(
              icon: Icons.chevron_right,
              onTap: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
