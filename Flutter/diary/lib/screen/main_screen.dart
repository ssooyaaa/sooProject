
import 'package:diary/config/app_colors.dart';
import 'package:diary/widget/app_bar.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:diary/widget/calendar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';



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


  //날짜 event
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024,9,3) : [Event(text: 'title1', color: 'red'), Event(text: 'title2',color: 'orange'),  Event(text: 'title2',color: 'yellow'),  Event(text: 'title2',color: 'green'),  Event(text: 'title2',color: 'blue'), Event(text: 'title2',color: 'purple'), Event(text: 'title2',color: 'black'), Event(text: 'title2',color: 'grey')],
    DateTime.utc(2024,9,4) : [Event(text: 'title3',color: 'black'), Event(text: 'title3',color: 'grey'),Event(text: 'title3', color: 'purple'),],
  };

  //eventList title만 뽑기
  List<String> getEventTitleForDay(DateTime day){
    final eventsForDay = events[day] ?? [];
    return eventsForDay.map((event) => event.text).toList();
  }

  //eventList color만 뽑기
  List<String> getEventColorForDay(DateTime day){
    final eventsForDay = events[day] ?? [];
    return eventsForDay.map((event) => event.color).toList();
  }

  //event가 있는 날짜만 뽑기
  List<Event> getEventForDay(DateTime day){
    return events[day] ?? [];
  }

  //colorMap(테이블 저장 color -> Colors로 변경)
  Map<String, Color> colorMap = {
    'red' : Colors.red,
    'orange' : Colors.orange,
    'yellow' : Colors.yellow,
    'green' : Colors.green,
    'blue' : Colors.blue,
    'purple' : Colors.purple,
    'black' : Colors.black,
    'grey' : Colors.grey,
  };



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      //루틴 화면 -> +버튼 루틴 추가 변경
      appBar: CustomAppBar(
        actions : [
          IconButton(
              onPressed: (){
                print('chart click');
              },
              icon: Icon(Icons.bar_chart)
          ),

          IconButton(
              onPressed: (){
                print('routine add click');
              },
              icon: Icon(Icons.add)
          )
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
                    });
                  },
                  calendarFormat: CalendarFormat.month,
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.moreBasicColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: (){},
          label: Text('TODAY',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
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

    return ListView.builder(
        itemCount: eventTitlesForSelectedDate.length,

        itemBuilder: (context, index){
          final text = eventTitlesForSelectedDate[index];
          final selectedcolor = eventColorsForSelectedDate[index];
          final color = colorMap[selectedcolor] ?? Colors.white;

          return ListTile(
            title: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 4.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
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
                    children: List.generate(
                        events.length,
                        (index){
                          final event = events[index];
                          final color = colorMap[event.color] ?? Colors.white;
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
                    ),
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
