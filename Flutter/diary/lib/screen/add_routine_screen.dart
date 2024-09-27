import 'package:diary/model/routine.dart';
import 'package:flutter/material.dart';


class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key});

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {

  //routines
  List<Routine> routines = [
    Routine(routine: '물 2L 마시기'),
    Routine(routine: '운동하기'),
    Routine(routine: '충분히 자기'),
  ];

  //루틴 가져오기
  List<String> getRoutines(){
    return routines.map((routine) => routine.routine).toList();
  }


  @override
  Widget build(BuildContext context) {


    //루틴list
    List<String> routineList = getRoutines();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('ROUTINE'),
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
                    return ListTile(
                      title: Text(routineList[index]),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
