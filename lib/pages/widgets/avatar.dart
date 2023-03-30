import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Semantics(
          image: true,
          label: 'A circle with a robot avatar on its top',
          child: Center(
            child: Container(
              height: 110,
              width: 120,
              margin: const EdgeInsets.only(
                top: 4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Container(
          height: 125,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/robot_avatar.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
