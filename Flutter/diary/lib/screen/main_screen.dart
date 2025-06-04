
import 'package:diary/app_http/today_routine_http.dart';
import 'package:diary/config/app_colors.dart';
import 'package:diary/model/todayRoutine_model.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/rountine_list_screen.dart';
import 'package:diary/screen/today_routine_screen.dart';
import 'package:diary/widget/app_bar.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:diary/widget/calendar_widget.dart';
import 'package:diary/widget/floating_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../LocalNotification.dart';
import '../model/routine_model.dart';
import '../vo/event.dart';
import '../vo/today_routine.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //선택된 날짜 관리변수
  DateTime selectedDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );

  late DateTime startDate;
  late DateTime endDate;

  late int loginIdx;
  late List<TodayRoutine> monthTodayRoutines = []; //초기 빈 리스트로 설정해두어야함.
  bool isLoading = true;

  Map<DateTime, List<Event>> events = {};


  @override
  void initState(){
    super.initState();

    loginIdx = Provider.of<UserModel>(context, listen: false).me!.userIdx;

    initializeRoutineList(selectedDate);
  }

  Future<void> initializeRoutineList(DateTime date) async{
    DateTime startDate = DateTime.utc(date.year, date.month-1, date.day);
    DateTime endDate = DateTime.utc(date.year, date.month+1, date.day);
    //await Provider.of<RoutineModel>(context, listen: false).setRoutineList(userIdx: loginIdx);

    monthTodayRoutines = await Provider.of<TodayRoutineModel>(context, listen: false).setMonthlyTodayRoutineList(startDate: startDate, endDate: endDate, userIdx: loginIdx);

    dataFormatForTodayRoutine();
  }


  //todo DataFormat
  void dataFormatForTodayRoutine(){
    var dateFormat = DateFormat('yyyy-MM-dd');

    events.clear();

    for(var one in monthTodayRoutines){
      String date = dateFormat.parse(one.savedDate).toString().substring(0,10);
      List<String> dateParts = date.split('-');

      DateTime savedDate = DateTime.utc(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2])
      );

      String routine = one.routines;
      String color = one.color;
      bool isChecked = one.isChecked;

      Event event = Event(text: routine, color: color, isChecked: isChecked);

      if(events[savedDate] == null){
        events[savedDate] = [event];
      }else
        events[savedDate]!.add(event);
    }

    /*print('events:$events');

    events.forEach((savedDate, eventList) {
      print('savedDate: $savedDate');
      eventList.forEach((event) {
        print('  Event: ${event.text}, Color: ${event.color}');
      });
    });
*/
    setState(() {
      isLoading = false;
    });
  }

  //날짜 event
 /* Map<DateTime, List<Event>> events = {
    DateTime.utc(2025,3,1) : [Event(text: 'title1', color: 'red'), Event(text: 'title2',color: 'orange'),  Event(text: 'title2',color: 'yellow'),  Event(text: 'title2',color: 'green'),  Event(text: 'title2',color: 'blue'), Event(text: 'title2',color: 'purple'), Event(text: 'title2',color: 'brown'), Event(text: 'title2',color: 'grey')],
    DateTime.utc(2025,3,4) : [Event(text: 'title3',color: 'brown'), Event(text: 'title3',color: 'grey'),Event(text: 'title3', color: 'purple'),],
  };*/



  //event가 있는 날짜(isChecked=true) 뽑기
  List<Event> getEventForDay(DateTime day){
    return (events[day] ?? []).where((event) => event.isChecked).toList();
  }

  //eventList title만 뽑기
  List<String> getEventTitleForDay(DateTime day){
    final eventsForDay = getEventForDay(day);
    return eventsForDay.map((event) => event.text).toList();
  }

  //eventList color만 뽑기
  List<String> getEventColorForDay(DateTime day){
    final eventsForDay = getEventForDay(day);
    return eventsForDay.map((event) => event.color).toList();
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      //루틴 화면 -> +버튼 루틴 추가 변경
      appBar: CustomAppBar(
        actions : [

          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RountineListScreen()),
                );
              },
              icon: Icon(Icons.add)
          ),

        ]
      ),

      //메인화면(달력)
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            Container(
              child: CalendarWidget(
                  eventLoader: (day) => getEventForDay(day),
                  calendarBuilders: calendarBuilders,
                  onDateSelected: (date){
                    setState(() {
                      selectedDate = date;
                      initializeRoutineList(date);
                    });
                  },
                  calendarFormat: CalendarFormat.month,
                  onPageChanged: (focusedDate){


                    setState(() {
                      selectedDate = focusedDate;

                      initializeRoutineList(selectedDate);
                    });
                  },
              ),
            ),

            SizedBox(height: 10.0,),

            Expanded(
                child: buildEventTitleList(),
            ),

          ],
        ),
      ),


      //오늘 루틴 추가하기 버튼 -> 다른 방법으로 바꿈
      floatingActionButton: FloatingButton(
        onScreenSelected: (context){
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodayRoutineScreen()),
          );
        },
        buttonText: 'TODAY',
      ),


    );


  }



  //event title list를 보여주는 위젯
  Widget buildEventTitleList(){
    final eventTitlesForSelectedDate = getEventTitleForDay(selectedDate);
    final eventColorsForSelectedDate = getEventColorForDay(selectedDate);


    //event가 없을 경우
    if(eventTitlesForSelectedDate.isEmpty){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text('아직 등록된 오늘의 루틴이 없습니다.'),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.basicColor,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0,),
                Text(
                  '${getEventForDay(selectedDate).length}개 완료',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
                itemCount: eventTitlesForSelectedDate.length,

                itemBuilder: (context, index){
                  final text = eventTitlesForSelectedDate[index];
                  final selectedcolor = eventColorsForSelectedDate[index];
                  final color = AppColors().colorMap[selectedcolor] ?? Colors.black;

                  return ListTile(
                    title: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: color,
                          ),
                          SizedBox(width: 8.0,),
                          Text(text,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );

  }


  //날짜 도트 설정
  CalendarBuilders calendarBuilders(){
    return CalendarBuilders(
        markerBuilder: (context, date, events){
          if(events.isNotEmpty){
            return Align( //Align : 도트가 셀의 하단에 맞춰서 배치되도록
                alignment: Alignment.bottomCenter,
                child: Container(

                  child: Wrap( //Wrap : 자동 줄바꿈
                    spacing: 1.0, //도트 사이의 간격
                    runSpacing: 2.0, //줄 사이의 간격
                    children: events
                        .where((event) => event.isChecked)
                        .map((event){

                          final color = AppColors().colorMap[event.color] ?? Colors.black;

                          return Container(
                            width: 7.0,
                            height: 7.0,
                            margin: EdgeInsets.only(right: 2.0),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          );
                    }).toList(),

                    /*List.generate(
                        events.length,
                        (index){
                          final event = events[index];
                          final color = AppColors().colorMap[event.color] ?? Colors.black;

                          return Container(
                            width: 7.0,
                            height: 7.0,
                            margin: EdgeInsets.only(right: 2.0),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          );
                        }
                    ),*/
                  ),
                )
            );
          }
          //event가 없는 경우 빈 위젯 반환
          return SizedBox.shrink();
        }
    );
  }
}
