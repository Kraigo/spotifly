import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle_outlined,
            size: 30.0,
          ),
          label: const Text('Marcus Ng'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          padding: const EdgeInsets.only(),
          icon: const Icon(Icons.keyboard_arrow_down, size: 30.0),
          onPressed: () {},
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }
}
