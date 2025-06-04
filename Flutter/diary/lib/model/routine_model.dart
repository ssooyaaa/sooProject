

import 'package:diary/app_http/routine_http.dart';
import 'package:diary/vo/routine.dart';
import 'package:diary/vo/today_routine.dart';
import 'package:flutter/material.dart';

class RoutineModel extends ChangeNotifier{

  List<Routine> routineList = [];


  //todo 기존에 있던 routineList가져오기
  Future<List<Routine>> setRoutineList({required int userIdx}) async{
    List<Routine> chunk = await RoutineHttp.getRoutineList(userIdx: userIdx);

    routineList = chunk; //기존 데이터 초기화 후 새로운 데이터 설정

    notifyListeners();

    return routineList;

  }


  //todo 루틴 삭제하기
  void delRoutineInList({required int index}){

    routineList.removeAt(index);

    notifyListeners();
  }


  //todo 루틴 더하기
  Future<void> addRoutineInList({required Routine routine}) async{
    routineList.add(routine);

    notifyListeners();
  }

}