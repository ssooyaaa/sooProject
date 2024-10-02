import 'package:diary/config/app_colors.dart';
import 'package:diary/widget/app_widget.dart';
import 'package:flutter/material.dart';

import '../model/routine.dart';



class TodayRoutineScreen extends StatefulWidget {
  const TodayRoutineScreen({super.key});

  @override
  State<TodayRoutineScreen> createState() => _TodayRoutineScreenState();
}

class _TodayRoutineScreenState extends State<TodayRoutineScreen> {

  //routines
  List<Routine> routines = [
    Routine(routine: '물 2L 마시기',color: 'blue'),
    Routine(routine: '운동하기', color: 'red'),
    Routine(routine: '충분히 자기', color: 'brown'),
  ];

  //루틴 가져오기
  List<String> getRoutines(){
    return routines.map((routine) => routine.routine).toList();
  }

  //색깔 가져오기
  List<String> getColors(){
    return routines.map((routine) => routine.color).toList();
  }

  //체크 상태 저장하는 리스트
  List<bool> checkedList = [];
  //todo 미리 체크되어야하는 루틴 리스트(리스트만 가져와야함)
  //List<String> preSelectedRoutines = ['물 충분히마시기' or 'idx'로];


  @override
  void initState(){
    super.initState();

    //checkedList를 routineList와 같은 길이로 초기화
    checkedList = List<bool>.filled(routines.length, false);

    //todo checkedList 초기화 : preSelectedRoutines에 포함된 루틴은 true
    //checkedList = routines.map((routine) => preSelectedRoutines.contains(routine)).toList();
  }


  @override
  Widget build(BuildContext context) {

    //루틴list
    List<String> routineList = getRoutines();
    List<String> colorList = getColors();

    print(routineList.length);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('TODAY ROUTINES'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),

        child: Column(
          //todo today루틴 체크박스로 저장하기
          children: [
            if(routineList.length==0)
              Text('저장되어있는 루틴이 없습니다.')
            else
              Expanded(
                child: ListView.builder(
                    itemCount: routineList.length,
                    itemBuilder: (context, index){
                      return CheckboxListTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColors().colorMap[colorList[index]],
                              ),
                              SizedBox(width: 8.0,),
                              Text(routineList[index],
                                style: TextStyle(fontSize: 18,),
                              ),
                            ],
                          ),

                          value: checkedList[index],
                          onChanged: (bool? value){
                            setState(() {
                              checkedList[index] = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                      );
                    }
                ),
              ),

            LongButton(
                //todo 버튼 저장시, 데이터 수정/저장
                onTap: (){},
                width: double.infinity,
                child: Center(
                  child: Text('오늘의 루틴 저장',
                    style: TextStyle(color: Colors.black, fontSize:17, fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: AppColors.basicColor,
            ),
          ],
        ),


      ),
    );
  }
}
