import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    var greeting = '';

    if (DateTime.now().hour >= 5 && DateTime.now().hour < 12) {
      greeting = 'Good morning';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
        top: 30,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        borderRadius: BorderRadius.circular(20).copyWith(
          topLeft: Radius.zero,
        ),
      ),
      child: AnimatedTextKit(
        isRepeatingAnimation: false,
        repeatForever: false,
        animatedTexts: [
          TyperAnimatedText(
            '$greeting, how can I help you today?',
            textStyle: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
