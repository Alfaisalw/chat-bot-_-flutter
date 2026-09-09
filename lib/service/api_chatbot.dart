import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiChatbot {

 Future<String> sendReq(String message) async {
    String link =
        "https://generativelanguage.googleapis.com/v1beta/interactions";
    var uri = Uri.parse(link);

    ////new
    Map<String, String>? header = {
      "x-goog-api-key":
          dotenv.get('api-key'),
    };

    Map<String, String>? body = {
      "model": "gemini-3.8-flash",
      "input": message,
    };

    var requrst = await http.post(uri, headers: header, body: jsonEncode(body));
    print(requrst.statusCode);

    var response = requrst.body;

    var responseBody = jsonDecode(response);

    return responseBody["steps"][1]["content"][0]["text"].toString();

    /////
    ///
  }
}