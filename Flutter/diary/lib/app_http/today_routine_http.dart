
import 'dart:async';
import 'dart:convert';

import 'package:diary/vo/today_routine.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';


class TodayRoutineHttp{

  //todo 오늘의 루틴 저장
  static Future<bool> saveTodayRoutine({required TodayRoutine todayRoutine}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/todayRoutine/saveTodayRoutine';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'routine_idx': todayRoutine.routineIdx.toString(),
      'saved_date': todayRoutine.savedDate.toString(),
      'is_checked': todayRoutine.isChecked.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok'){
      return true;
    }else
      return false;

  }


  //todo 오늘의 루틴 삭제
  static Future<bool> delTodayRoutine({required TodayRoutine tr}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/todayRoutine/delTodayRoutine';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'routine_idx': tr.routineIdx.toString(),
      'saved_date': tr.savedDate.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok')
      return true;
    else
      return false;
  }


  //todo 오늘의 루틴 가져오기
  static Future<List<TodayRoutine>> getTodayRoutines({required String savedDate, required int userIdx}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/todayRoutine/getTodayRoutines';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'saved_date': savedDate.toString(),
      'user_idx': userIdx.toString(),
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<TodayRoutine> todayRoutineList = [];
    for(var one in data){
      TodayRoutine tr = TodayRoutine.fromJson(one);
      todayRoutineList.add(tr);
    }

    return todayRoutineList;
  }


  //todo 오늘의 루틴 체크 업데이트
  static Future<bool> updateTodayRoutine({required bool isChecked, required int routineIdx, required String savedDate}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/todayRoutine/updateTodayRoutine';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'is_checked': isChecked.toString(),
      'routine_idx': routineIdx.toString(),
      'saved_date':savedDate.toString()
    });


    var response = await http.post(urlParam);

    if(response.body=='ok')
      return true;
    else
      return false;
  }


  //todo 오늘의 루틴 월로
  static Future<List<TodayRoutine>> getMonthRoutines({required DateTime startDate, required DateTime endDate, required int userIdx}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/todayRoutine/getMonthRoutines';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
      'user_idx': userIdx.toString()
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<TodayRoutine> monthTodayRoutines = [];
    for (var one in data) {
      TodayRoutine tr = TodayRoutine.fromJson(one);
      monthTodayRoutines.add(tr);
    }

    return monthTodayRoutines;
  }

}