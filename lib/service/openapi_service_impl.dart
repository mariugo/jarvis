import 'dart:convert';

import 'package:jarvis/constants/app_constants.dart';
import 'package:jarvis/service/openapi_service.dart';
import 'package:http/http.dart' as http;

class OpenAPIServiceImpl implements OpenAPIService {
  final List<Map<String, String>> messages = [];

  @override
  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      var response = await http.post(
        Uri.parse(
          'https://api.openai.com/v1/chat/completions',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAPIKey",
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": messages,
          },
        ),
      );

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content.trim();

        messages.add({
          "role": "assistant",
          "content": content,
        });
        return content;
      }
      return 'An error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> dallEAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      var response = await http.post(
        Uri.parse(
          'https://api.openai.com/v1/images/generations',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAPIKey",
        },
        body: jsonEncode(
          {
            "prompt": prompt,
            "n": 1,
          },
        ),
      );

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)['data'][0]['url'];
        imageUrl.trim();

        messages.add({
          "role": "assistant",
          "content": imageUrl,
        });
        return imageUrl;
      }
      return 'An error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> isArtPrompt(String prompt) async {
    try {
      var response = await http.post(
        Uri.parse(
          'https://api.openai.com/v1/chat/completions',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAPIKey",
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Doest this message want to generate an AI picture, image, art, drawing or anything similar? $prompt . Simply answer with a yes or no",
              }
            ]
          },
        ),
      );

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
          case 'YES':
          case 'YES.':
            var res = await dallEAPI(prompt);
            return res;
          default:
            var res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An error occurred.';
    } catch (e) {
      return e.toString();
    }
  }
}
