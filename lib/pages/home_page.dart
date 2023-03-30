import 'package:flutter/material.dart';
import 'package:jarvis/pages/widgets/avatar.dart';
import 'package:jarvis/pages/widgets/chat_bubble.dart';
import 'package:jarvis/pages/widgets/commands_container.dart';
import 'package:jarvis/pages/widgets/commands_text.dart';
import 'package:jarvis/service/openapi_service_impl.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText speechToText = SpeechToText();
  final OpenAPIServiceImpl openAPIService = OpenAPIServiceImpl();
  String mySpeech = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   speechToText.stop();
  // }

  // Speech To Text Methods
  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      mySpeech = result.recognizedWords;
    });
  }

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
        onPressed: () async {
          if (speechToText.isNotListening) {
            await startListening();
          } else {
            var speech = await openAPIService.isArtPrompt(mySpeech);
            print('========= SPEECH: $speech ==============');
            await stopListening();
          }
          //speechToText.isNotListening ? startListening() : stopListening();

          // print('================ ENTROU NO BUTTON ==============');
          // if (await speechToText.hasPermission && speechToText.isNotListening) {
          //   print(
          //       '================ ENTROU NO haspermisson isnotlistening ==============');
          //   await startListening();
          // } else if (speechToText.isListening) {
          //   print('================ ENTROU NO islistening ==============');

          //   //String speech = await openAPIService.isArtPrompt(mySpeech);
          //   //print('================ SPEECHRESULT $speech ==============');
          //   await stopListening();
          // } else {
          //   initSpeechToText();
          // }
        },
        child: Icon(
          speechToText.isNotListening ? Icons.mic : Icons.mic_off,
        ),
      ),
    );
  }
}
