import 'package:diary/app_http/routine_http.dart';
import 'package:diary/app_http/today_routine_http.dart';
import 'package:diary/config/app_colors.dart';
import 'package:diary/model/todayRoutine_model.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:diary/vo/today_routine.dart';
import 'package:diary/widget/app_widget.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/routine_model.dart';
import '../model/user_model.dart';
import '../vo/routine.dart';



class TodayRoutineScreen extends StatefulWidget {
  const TodayRoutineScreen({super.key});

  @override
  State<TodayRoutineScreen> createState() => _TodayRoutineScreenState();
}

class _TodayRoutineScreenState extends State<TodayRoutineScreen> {


  //선택된 날짜 관리변수
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );

  late int loginIdx;
  late List<Routine> routineList = []; //초기 빈 리스트로 설정해두어야함.
  late List<TodayRoutine> todayRoutineList = [];
  bool isLoading = true;
  int routineCount = 0;

  //체크 상태 저장하는 리스트
  List<bool> checkedList = [];


  @override
  void initState(){
    super.initState();

    loginIdx = Provider.of<UserModel>(context, listen: false).me!.userIdx;

    initializeTodayRoutineList();
  }

  Future<void> initializeTodayRoutineList() async{
    await Provider.of<RoutineModel>(context, listen: false).setRoutineList(userIdx: loginIdx);
    await Provider.of<TodayRoutineModel>(context, listen: false).setTodayRoutineList(savedDate: today.toString(), userIdx: loginIdx);

    routineList = await Provider.of<RoutineModel>(context, listen: false).routineList;
    todayRoutineList = await Provider.of<TodayRoutineModel>(context, listen: false).todayRoutineList;


    print('routineList:${routineList.length}');
    print('today:${todayRoutineList.length}');
    if(routineList.length != todayRoutineList.length){
      for(int i=0;i<routineList.length;i++){
        TodayRoutine tr = TodayRoutine(
          routineIdx: routineList[i].routineIdx,
          savedDate: today.toString(),
          isChecked: false
        );
        await TodayRoutineHttp.saveTodayRoutine(todayRoutine: tr);
      };
      await Provider.of<TodayRoutineModel>(context, listen: false).setTodayRoutineList(savedDate: today.toString(), userIdx: loginIdx);
    }


    todayRoutineList = await Provider.of<TodayRoutineModel>(context, listen: false).todayRoutineList;

    print('routineList:${routineList.length}');
    print('today:${todayRoutineList.length}');


    //checkedList를 routineList와 같은 길이로 초기화
    //checkedList = List<bool>.filled(todayRoutineList, false);
    checkedList = await todayRoutineList.map((routine) => routine.isChecked).toList();

    setState(() {
      isLoading = false;
    });

  }




  @override
  Widget build(BuildContext context) {

    if(isLoading)
      return Center(child: CircularProgressIndicator(),);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //todo today루틴 체크박스로 저장하기
          children: [
            if(routineList.length==0)
              Text('저장되어있는 루틴이 없습니다.')
            else
              Expanded(
                child: ListView.builder(
                    itemCount: routineList.length,
                    itemBuilder: (context, index){
                      final todayRoutine = routineList[index].routines;
                      final selectedColor = routineList[index].color;
                      final color = AppColors().colorMap[selectedColor];

                      return CheckboxListTile(

                          title: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: color,
                              ),
                              SizedBox(width: 8.0,),
                              Text(todayRoutine,
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
                onTap: () async{

                  bool allSuccess = true;

                  for(int i=0;i<todayRoutineList.length;i++){
                    var res = await TodayRoutineHttp.updateTodayRoutine(isChecked: checkedList[i], routineIdx: todayRoutineList[i].routineIdx, savedDate: todayRoutineList[i].savedDate);

                    if(!res){
                      allSuccess = false;
                      break;
                    }
                  }

                  if(allSuccess){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('오늘의 루틴이 저장되었습니다.')),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomWidget(bottomSelectedIdx: 0)),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('다시 한번 시도해주세요.')),
                    );
                  }



                },
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
