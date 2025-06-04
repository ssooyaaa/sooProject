import 'dart:convert';

import 'package:diary/vo/diary.dart';
import 'package:diary/vo/diary_img.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';


class DiaryHttp{


  //todo 다이어리 등록
  static Future<bool> save({
    required int userIdx,
    required String title,
    required String content,
    required String savedDate,
    required List<String> imgUrlList,
    required List<String> storageRefList,
    required String songUrl,
  }) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/save';
    Uri uri = Uri.parse(requestUrl);

    var response = await http.post(
      uri,
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        'user_idx': userIdx,
        'title': title,
        'content': content,
        'saved_date': savedDate,
        'img_urls': imgUrlList,
        'storage_refs': storageRefList,
        'song_url': songUrl,
      })
    );

    if(response.body=='ok' && response.statusCode==200){
      return true;
    }else{
      return false;
    }


  }



  //todo 다이어리 월로
  static Future<List<Diary>> getMonthlyDiary({required DateTime startDate, required DateTime endDate, required int userIdx}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/getMonthlyDiary';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
      'user_idx': userIdx.toString()
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Diary> monthDiary = [];
    for (var one in data) {
      Diary di = Diary.fromJson(one);
      monthDiary.add(di);
    }

    return monthDiary;
  }


  //todo 다이어리 이미지 가져오기
  static Future<List<DiaryImg>> getDiaryImgs({required int diaryIdx, required DateTime createdDate}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/getDiaryImgs';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'diary_idx': diaryIdx.toString(),
      'created_date': createdDate.toString(),
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<DiaryImg> imgs = [];
    for (var one in data) {
      DiaryImg di = DiaryImg.fromJson(one);
      imgs.add(di);
    }

    return imgs;
  }

  //todo 오늘의 다이어리 가져오기
  static Future<Diary?> getTodayDiary({required int diaryIdx}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/getTodayDiary';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'diary_idx': diaryIdx.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return Diary.fromJson(json);
    }else
      return null;
  }


  //todo 오늘의 다이어리 이미지 가져오기
  static Future<List<DiaryImg>> getTodayDiaryImgs({required int diaryIdx,}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/getTodayDiaryImgs';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'diary_idx': diaryIdx.toString(),
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // 데이터가 비어 있으면 빈 리스트를 반환
    if (data == null || data.isEmpty) {
      return [];  // 데이터가 없으면 빈 리스트 반환
    }

    List<DiaryImg> imgs = [];
    for (var one in data) {
      DiaryImg di = DiaryImg.fromJson(one);
      imgs.add(di);
    }

    return imgs;
  }


  //todo 오늘의 다이어리와 이미지 가져오기
  static Future<List<dynamic>> getTodayDiaryAndImgs({required int diaryIdx}) async{

    Future<Diary?> getDiary = getTodayDiary(diaryIdx: diaryIdx);
    Future<List<DiaryImg>> getImgs = getTodayDiaryImgs(diaryIdx: diaryIdx);

    var diary = await getDiary;
    var images = await getImgs;

    if(diary!=null){
      return [diary, images];
    }else{
      return [];
    }

  }

  //todo 다이어리 수정
  static Future<bool> modifyTodayDiary({
    required int diaryIdx,
    required int userIdx,
    required String title,
    required String content,
    required String savedDate,
    required List<String> imgUrlList,
    required List<String> storageRefList,
    required String songUrl,
  }) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/modifyTodayDiary';
    Uri uri = Uri.parse(requestUrl);

    var response = await http.post(
        uri,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          'diary_idx': diaryIdx,
          'user_idx': userIdx,
          'title': title,
          'content': content,
          'saved_date': savedDate,
          'img_urls': imgUrlList,
          'storage_refs': storageRefList,
          'song_url': songUrl
        })
    );

    if(response.body=='ok' && response.statusCode==200){
      return true;
    }else{
      return false;
    }

  }

  //todo 오늘의 다이어리 삭제
  static Future<bool> delSelectedDiary({required int diaryIdx}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/diary/delSelectedDiary';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'diary_idx': diaryIdx.toString(),
    });

    var response = await http.post(urlParam);


    if(response.body=='ok'){
     return true;
   }else
     return false;
  }

}