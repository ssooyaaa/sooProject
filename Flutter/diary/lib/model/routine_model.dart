

import 'package:diary/app_http/routine_http.dart';
import 'package:diary/vo/routine.dart';
import 'package:flutter/material.dart';

class RoutineModel extends ChangeNotifier{

  List<Routine> routineList = [];


  Future<void> setRoutineList({required int userIdx}) async{
    List<Routine> chunk = await RoutineHttp.getRoutineList(userIdx: userIdx);

    routineList = chunk; //기존 데이터 초기화 후 새로운 데이터 설정
    notifyListeners();
  }

}