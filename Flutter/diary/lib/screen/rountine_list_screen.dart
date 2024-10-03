import 'package:diary/config/app_config.dart';
import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../model/routine.dart';
import '../widget/app_widget.dart';
import '../widget/floating_button.dart';


class RountineListScreen extends StatefulWidget {
  const RountineListScreen({super.key});

  @override
  State<RountineListScreen> createState() => _RountineListScreenState();
}

class _RountineListScreenState extends State<RountineListScreen> {


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


  @override
  Widget build(BuildContext context) {


    //루틴list
    List<String> routineList = getRoutines();
    List<String> colorList = getColors();


    //input Controller
    TextEditingController titleController = TextEditingController();


    //선택된 색상(루틴 추가시)
    String selectedColor = '';


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('ROUTINES'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),

        child: Column(
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
                                            textEditingController: titleController,
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
                              Navigator.of(context).pop(false); //삭제 취소
                            },
                            child: Text('취소',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: (){

                              //todo 루틴 저장 / 수정

                              if(titleController.text.isEmpty){
                                AppConfig.showToast(text: '루틴 이름을 적어주세요');
                                return;
                              }

                              if(selectedColor.isEmpty){
                                AppConfig.showToast(text: '색상을 선택해주세요');
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('루틴이 저장되었습니다.')),
                              );
                              Navigator.of(context).pop(true); //삭제 취소
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
