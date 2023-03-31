import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jarvis/pages/widgets/avatar.dart';
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
  final openAPIService = OpenAPIServiceImpl();
  final flutterTts = FlutterTts();
  final speechToText = SpeechToText();
  String mySpeech = '';
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  @override
  void dispose() {
    speechToText.stop();
    flutterTts.stop();
    super.dispose();
  }

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

  // Text to Speech Methods
  Future<void> systemSpeak(String speech) async {
    await flutterTts.speak(speech);
  }

  Future<void> voiceAssistant() async {
    if (speechToText.isNotListening) {
      await startListening();
    } else {
      var speech = await openAPIService.isArtPrompt(mySpeech);
      if (speech.contains('https')) {
        generatedImageUrl = speech;
        generatedContent = null;
        setState(() {});
      } else {
        generatedImageUrl = null;
        generatedContent = speech;
        setState(() {});
        await systemSpeak(speech);
      }
      await stopListening();
    }
  }

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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ZoomIn(
                child: const Avatar(),
              ),
              Visibility(
                visible: generatedImageUrl == null,
                child: Container(
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
                  child: generatedContent == null
                      ? AnimatedTextKit(
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          animatedTexts: [
                            TyperAnimatedText(
                              '$greeting, how can I help you today?',
                              textStyle: TextStyle(
                                fontSize: generatedContent == null ? 25 : 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        )
                      : FadeInRight(
                          child: Text(
                            '$generatedContent',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                ),
              ),
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: const CommandsText(),
              ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInUp(
                      delay: Duration(milliseconds: start),
                      child: CommandsContainer(
                        title: 'ChatGPT',
                        description:
                            'Ask questions and get smart answers powered by ChatGPT.',
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        fontColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SlideInUp(
                      delay: Duration(milliseconds: start + delay),
                      child: CommandsContainer(
                        title: 'Dall-E',
                        description:
                            'Get inspiring and unique pictures powered by Dall-E.',
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        fontColor:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + (2 * delay)),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          onPressed: () async => await voiceAssistant(),
          child: Icon(
            speechToText.isNotListening ? Icons.mic : Icons.stop,
          ),
        ),
      ),
    );
  }
}
