import 'package:flutter/material.dart';
import 'package:jarvis/pages/widgets/avatar.dart';
import 'package:jarvis/pages/widgets/chat_bubble.dart';
import 'package:jarvis/pages/widgets/commands_container.dart';
import 'package:jarvis/pages/widgets/commands_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Avatar(),
              const ChatBubble(),
              const CommandsText(),
              Column(
                children: [
                  CommandsContainer(
                    title: 'ChatGPT',
                    description:
                        'Ask questions and get smart answers powered by ChatGPT.',
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    fontColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  CommandsContainer(
                    title: 'Dall-E',
                    description:
                        'Get inspiring and unique pictures powered by Dall-E.',
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    fontColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
        onPressed: () {},
        child: const Icon(Icons.mic),
      ),
    );
  }
}
