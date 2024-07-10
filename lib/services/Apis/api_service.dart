import 'dart:convert';

import 'package:mcqtest/services/Apis/api_path.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Future<Map<String, dynamic>> getRandomQuestions() async {
    final res = http.Request('GET', Uri.parse(APIPath.questionsUrl));

    http.StreamedResponse response = await res.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      return {
        'status': true,
        'data': data,
      };
    } else {
      return {
        'status': false,
        'message': 'Failed to fetch data',
        'code ': response.statusCode,
      };
    }
  }

  static Future<Map<String, dynamic>> getQuestionsById(String id) async {
    final res = http.Request('GET', Uri.parse('${APIPath.questionById}/$id'));

    http.StreamedResponse response = await res.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      data['status'] = true;

      return data;
    } else {
      return {
        'status': false,
        'message': 'Failed to fetch data',
        'code ': response.statusCode,
      };
    }
  }
}
