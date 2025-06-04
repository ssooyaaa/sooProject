import 'dart:convert';

import 'package:diary/app_http/routine_http.dart';
import 'package:diary/app_http/today_routine_http.dart';
import 'package:diary/config/app_config.dart';
import 'package:diary/model/routine_model.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/vo/today_routine.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../vo/routine.dart';
import '../widget/app_widget.dart';
import '../widget/floating_button.dart';
import 'main_screen.dart';


class RountineListScreen extends StatefulWidget {
  const RountineListScreen({super.key});

  @override
  State<RountineListScreen> createState() => _RountineListScreenState();
}

class _RountineListScreenState extends State<RountineListScreen> {

  //선택된 날짜 관리변수
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );

  late int loginIdx;
  late List<Routine> routineList = []; //초기 빈 리스트로 설정해두어야함.
  bool isLoading = true;
  int routineCount = 0;

  @override
  void initState(){
    super.initState();

    loginIdx = Provider.of<UserModel>(context, listen: false).me!.userIdx;

    initializeRoutineList();
  }

  Future<void> initializeRoutineList() async{
    await Provider.of<RoutineModel>(context, listen: false).setRoutineList(userIdx: loginIdx);


    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {

    routineList = Provider.of<RoutineModel>(context, listen: false).routineList;
    routineCount = routineList.length;

    //input Controller
    TextEditingController routineController = TextEditingController();

    //선택된 색상(루틴 추가시)
    String selectedColor = '';

    if(isLoading)
      return Center(child: CircularProgressIndicator(),);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('ROUTINES'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomWidget(bottomSelectedIdx: 0)),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),

        child: Consumer<RoutineModel>(builder: (context, routineModel, child){

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(routineList.isEmpty)
                Text(
                  '아직 추가된 루틴이 없습니다.',
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: routineList.length,
                    itemBuilder: (context, index){
                      final routine = routineList[index].routines;
                      final selectedColor = routineList[index].color;
                      final color = AppColors().colorMap[selectedColor];

                      return Dismissible(
                        key: Key(routine),
                        direction: DismissDirection.endToStart,

                        //팝업창 띄우기
                        confirmDismiss: (direction) async{
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('삭제 확인', style: TextStyle(fontWeight: FontWeight.bold),),
                                  content: Text('${routine}을(를) 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop(false); //삭제 취소
                                      },
                                      child: Text('취소',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async{
                                        int idx = routineList[index].routineIdx;

                                        //todo 루틴 삭제하기(api)
                                        var response = await RoutineHttp.changeRoutineColor(routineIdx: idx);

                                        if(response){
                                          //todo 오늘의 루틴 삭제하기(api)
                                          TodayRoutine tr = TodayRoutine(
                                              routineIdx: idx,
                                              savedDate: today.toString()
                                          );
                                          var res = await TodayRoutineHttp.delTodayRoutine(tr: tr);

                                          if(res){

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('${routine} 삭제되었습니다.')),
                                            );


                                            Navigator.of(context).pop(true); //삭제

                                          }else{
                                            AppConfig.showToast(text: '다시 한번 시도해주세요');
                                          }

                                        }

                                      },
                                      child: Text('삭제',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],
                                );
                              }
                          );
                        },

                        onDismissed: (direction){
                          setState(() {
                            routineList.removeAt(index);
                          });

                        },

                        background: Container(
                          color: AppColors.basicColor,
                          padding: EdgeInsets.only(right: 16.0),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),

                        child: ListTile(
                          title: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: color,
                                  ),
                                  SizedBox(width: 15.0,),
                                  Text(routine),
                                ],
                              )
                          ),
                        ),
                      );
                    },
                  ),
                ),

              LongButton(
                onTap: (){
                  //showDialog(팝업창)
                  showDialog(
                      context: context,
                      barrierDismissible: false,//팝업 밖 터치 -> 팝업창 사라짐
                      builder: (BuildContext context){
                        return AlertDialog(
                          content: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/2,

                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [

                                            //루틴 제목, 루틴 색상 결정, 버튼
                                            SizedBox(height: 10.0,),
                                            buildTitle(titleText: 'ROUTINE'),
                                            AppInput(
                                              width: double.infinity,
                                              textEditingController: routineController,
                                              hintText: '루틴 이름',
                                            ),

                                            SizedBox(height: 32.0,),
                                            buildTitle(titleText: 'COLOR'),

                                            StatefulBuilder(
                                                builder: (context, setDialogState) {
                                                  return Wrap(
                                                    spacing: 8.0,//수평 간격
                                                    runSpacing: 8.0, // 수직 간격
                                                    alignment: WrapAlignment.center,
                                                    children: AppColors().colorMap.entries.map((entry){
                                                      return GestureDetector(

                                                        onTap: (){
                                                          setDialogState(() {
                                                            selectedColor = entry.key;
                                                          });
                                                          print('entry.key :${entry.key}');
                                                          print('selected : $selectedColor');
                                                        },

                                                        child: Container(
                                                          margin: EdgeInsets.all(8.0),
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: entry.value,
                                                              shape: BoxShape.circle,
                                                              border: Border.all(
                                                                color: selectedColor == entry.key
                                                                    ? Colors.black
                                                                    : Colors.transparent,
                                                                width: 3.0,
                                                              )
                                                          ),
                                                        ),

                                                      );
                                                    }).toList(),
                                                  );
                                                }
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop(false); //창 끄기
                              },
                              child: Text('취소',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () async{

                                //todo 루틴 저장 / 수정

                                if(routineController.text.isEmpty){
                                  AppConfig.showToast(text: '루틴 이름을 적어주세요');
                                  return;
                                }

                                if(selectedColor.isEmpty){
                                  AppConfig.showToast(text: '색상을 선택해주세요');
                                  return;
                                }

                                if(routineCount>8){
                                  AppConfig.showToast(text: '저장 가능한 루틴의 개수가 초과하였습니다');
                                  return;
                                }

                                Routine routine = Routine(
                                    userIdx: loginIdx ?? 0,
                                    routines: routineController.text,
                                    color: selectedColor
                                );

                                var response = await RoutineHttp.saveRoutine(routine: routine);

                                if(response != 0){

                                  TodayRoutine todayRoutine = TodayRoutine(
                                      routineIdx: response ?? 0,
                                      savedDate: today.toString(),
                                      isChecked: false
                                  );

                                  var res = await TodayRoutineHttp.saveTodayRoutine(todayRoutine: todayRoutine);

                                  if(res){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('루틴이 저장되었습니다.')),
                                    );

                                    setState(() {
                                      initializeRoutineList();
                                    });
                                    Navigator.of(context).pop(true); //창 끄기
                                  }

                                }

                              },
                              child: Text('저장',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),

                          ],
                        );
                      }
                  );
                },
                width: double.infinity,
                child: Center(
                  child: Text('루틴 추가',
                    style: TextStyle(color: Colors.black, fontSize:17, fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: AppColors.basicColor,
              ),
            ],
          );
        }),

        /*Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(routineList.isEmpty)
              Text(
                '아직 추가된 루틴이 없습니다.',
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: routineList.length,
                  itemBuilder: (context, index){
                    final routine = routineList[index];
                    final selectedColor = colorList[index];
                    final color = AppColors().colorMap[selectedColor];

                    return Dismissible(
                      key: Key(routine),
                      direction: DismissDirection.endToStart,

                      //팝업창 띄우기
                      confirmDismiss: (direction) async{
                        return await showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('삭제 확인', style: TextStyle(fontWeight: FontWeight.bold),),
                                content: Text('${routine}을(를) 삭제하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop(false); //삭제 취소
                                    },
                                    child: Text('취소',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop(true); //삭제
                                    },
                                    child: Text('삭제',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                ],
                              );
                            }
                        );
                      },

                      onDismissed: (direction){
                        setState(() {
                          routineList.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${routine} 삭제되었습니다.')),
                        );
                      },

                      background: Container(
                        color: AppColors.basicColor,
                        padding: EdgeInsets.only(right: 16.0),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),

                      child: ListTile(
                        title: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: color,
                                ),
                                SizedBox(width: 8.0,),
                                Text(routine),
                              ],
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),

            LongButton(
              onTap: (){
                //showDialog(팝업창)
                showDialog(
                    context: context,
                    barrierDismissible: false,//팝업 밖 터치 -> 팝업창 사라짐
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,

                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                     child: SingleChildScrollView(
                                      child: Column(
                                        children: [

                                          //루틴 제목, 루틴 색상 결정, 버튼
                                          SizedBox(height: 10.0,),
                                          buildTitle(titleText: 'ROUTINE'),
                                          AppInput(
                                            width: double.infinity,
                                            textEditingController: routineController,
                                            hintText: '루틴 이름',
                                          ),

                                          SizedBox(height: 32.0,),
                                          buildTitle(titleText: 'COLOR'),

                                          StatefulBuilder(
                                            builder: (context, setDialogState) {
                                              return Wrap(
                                                spacing: 8.0,//수평 간격
                                                runSpacing: 8.0, // 수직 간격
                                                alignment: WrapAlignment.center,
                                                children: AppColors().colorMap.entries.map((entry){
                                                  return GestureDetector(

                                                    onTap: (){
                                                      setDialogState(() {
                                                        selectedColor = entry.key;
                                                      });
                                                      print('entry.key :${entry.key}');
                                                      print('selected : $selectedColor');
                                                    },

                                                    child: Container(
                                                      margin: EdgeInsets.all(8.0),
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: entry.value,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: selectedColor == entry.key
                                                              ? Colors.black
                                                              : Colors.transparent,
                                                          width: 3.0,
                                                        )
                                                      ),
                                                    ),

                                                  );
                                                }).toList(),
                                              );
                                            }
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop(false); //창 끄기
                            },
                            child: Text('취소',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () async{

                              //todo 루틴 저장 / 수정

                              if(routineController.text.isEmpty){
                                AppConfig.showToast(text: '루틴 이름을 적어주세요');
                                return;
                              }

                              if(selectedColor.isEmpty){
                                AppConfig.showToast(text: '색상을 선택해주세요');
                                return;
                              }

                              print('루틴저장');

                              Routine routine = Routine(
                                userIdx: loginIdx ?? 0,
                                routines: routineController.text,
                                color: selectedColor
                              );

                              var response = await RoutineHttp.saveRoutine(routine: routine);


                              if(response){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('루틴이 저장되었습니다.')),
                                );

                                setState(() {
                                  routine = Routine();
                                });
                                Navigator.of(context).pop(true); //창 끄기
                              }

                            },
                            child: Text('저장',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      );
                    }
                );
              },
              width: double.infinity,
              child: Center(
                child: Text('루틴 추가',
                  style: TextStyle(color: Colors.black, fontSize:17, fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: AppColors.basicColor,
            ),
          ],
        ),
*/

      ),

    );
  }
}



Widget buildTitle({required String titleText}){
  return Padding(
    padding: EdgeInsets.only(bottom: 16.0),
    child: Row(
      children: [
        Text('$titleText', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
      ],
    ),
  );
}
