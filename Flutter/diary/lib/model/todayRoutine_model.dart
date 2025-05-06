

import 'package:diary/app_http/today_routine_http.dart';
import 'package:diary/vo/today_routine.dart';
import 'package:flutter/cupertino.dart';

import '../app_http/routine_http.dart';

class TodayRoutineModel extends ChangeNotifier{


  List<TodayRoutine> todayRoutineList = [];


  Future<void> setTodayRoutineList({required String savedDate, required int userIdx}) async{
    List<TodayRoutine> chunk = await TodayRoutineHttp.getTodayRoutines(savedDate: savedDate, userIdx: userIdx);

    todayRoutineList = chunk; //기존 데이터 초기화 후 새로운 데이터 설정
    notifyListeners();
  }

}