
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../vo/routine.dart';

class RoutineHttp{

  //todo 루틴 저장
  static Future<int> saveRoutine({required Routine routine}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/routine/saveRoutine';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'user_idx': routine.userIdx.toString(),
      'routines': routine.routines.toString(),
      'color': routine.color.toString(),
    });

    var response = await http.post(urlParam);

    if (response.statusCode == 200) {
      return int.parse(response.body);
    }else
      return 0;

  }


  //todo 루틴 리스트 가져오기
  static Future<List<Routine>> getRoutineList({required int userIdx}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/routine/getRoutineList';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'user_idx': userIdx.toString(),
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Routine> routineList = [];
    for(var one in data){
      Routine r = Routine.fromJson(one);
      routineList.add(r);
    }

    return routineList;
  }


  //todo 루틴 삭제 -> 색변경
  static Future<bool> changeRoutineColor({required int routineIdx}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/routine/changeRoutineColor';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'routine_idx': routineIdx.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok'){
      return true;
    }else
      return false;

  }




}