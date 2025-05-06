

import 'dart:ffi';

class TodayRoutine{

  int todayRoutineIdx = 0;
  int routineIdx = 0;
  String savedDate = '';
  bool isChecked = false;
  String routines = '';
  String color = '';

  TodayRoutine({
    this.todayRoutineIdx = 0,
    this.routineIdx = 0,
    this.savedDate = '',
    this.isChecked = false,
    this.routines = '',
    this.color = ''
  });

  factory TodayRoutine.fromJson(Map<String, dynamic> map){
    return TodayRoutine(
      todayRoutineIdx: map['today_routine_idx']??0,
      routineIdx: map['routine_idx']??0,
      savedDate: map['saved_date']??'',
      isChecked: map['is_checked']??'',
      routines: map['routines']??'',
      color: map['color']??'',
    );
  }

}