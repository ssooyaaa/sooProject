
import 'dart:convert';

import 'package:http/http.dart' as http;


class YoutubeHttp{

  static Future<String> selectYoutubeVideo(String query) async{

    const String apiKey = '';

    final String apiUrl =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if items array is empty
        if (data['items'] == null || data['items'].isEmpty) {
          return '존재하는 음악이 없습니다.';
        }

        final videoId = data['items'][0]['id']['videoId'];
        return 'https://www.youtube.com/watch?v=$videoId';
      } else {
        print('Failed to fetch video: ${response.statusCode}');
        return '유튜브 검색 중 오류가 발생했습니다.';
      }
    } catch (e) {
      print('Exception occurred: $e');
      return '오류가 발생했습니다. 네트워크를 확인해주세요.';
    }

  }
}
