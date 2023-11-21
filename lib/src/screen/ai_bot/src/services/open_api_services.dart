import 'dart:convert';


import 'package:doktor_plus/src/screen/ai_bot/src/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class AIServices {
  final List<Map<String, String>> messages = [];

  

  Future<String> chatGPT(String prompt) async {
    messages.add(
      {
        'role': 'user',
        'content': prompt,
      },
    );
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages":  [
              {
                'role': 'user',
                'content':
                    'Act as a chat bot and give what diagnosis required for user provided symptom in a paragraph of less than 100 words? $prompt . ',
              }
            ],
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  
}
