import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_now/model/data_model/api_result.dart';


class GeminiApiCall {
  
  

  GeminiApiCall();

  static const String apiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$apiKey";
  static const String apiKey = "AIzaSyBey5Jf8tmCkmuKwls_Jwn5M-0d5pKwqLY";

  Future<ApiResult> makeRequest({
    required String noteContent,
  }) async {

    try {
      print("Started calling the api");
      
      final response = await http.post(
        Uri.parse(apiUrl),
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': 'Bearer $apiKey',
        // },
        body: jsonEncode({
          "contents" : [
            {
              "role": "user",
              "parts": [
                {
                  "text" : "Summarize $noteContent"
                }
              ]
            }
          ]
        },
      ));

      

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ApiResult(
          success: true,
          message: "Request successful",
          data: responseData['candidates'][0]["content"]["parts"][0]["text"],
        );
      } else {
        return ApiResult(
          success: false, 
          message: "Request failed",
        );
      }

      


    } catch (e) {
      print("This is the error i'm getting $e");

      return ApiResult(
        success: false, 
        message: "An error occured, please check your internet and try again!",
      );
    }
    
    
  }
    
}