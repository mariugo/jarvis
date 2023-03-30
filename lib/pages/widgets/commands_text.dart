import 'package:flutter/material.dart';

class CommandsText extends StatelessWidget {
  const CommandsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10, left: 22),
      child: Text(
        'Here are the things I can do for you:',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
