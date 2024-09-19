import 'dart:ffi';

import 'package:diary/model/story.dart';
import 'package:diary/widget/app_bar.dart';
import 'package:diary/widget/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  //선택된 날짜 관리변수
  DateTime selectedDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );


  //달력 format
  CalendarFormat newFormat = CalendarFormat.month;


  //날짜 event
  Map<DateTime, Story> event = {
    DateTime.utc(2024,9,3) : Story(
        title: '오늘의 일기',
        text: '가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하'
    ),
    DateTime.utc(2024,9,10) : Story(
        title: '오늘의 일기',
        text: '가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하'
    ),
  };

  //story title만 뽑기
  String getStoryTitleForDay(DateTime day){
    final eventsForDay = event[day];
    return eventsForDay?.title ?? '';
  }

  //story text만 뽑기
  String getStoryTextForDay(DateTime day){
    final eventsForDay = event[day];
    return eventsForDay?.text ?? '';
  }

  //story가 있는 날짜만 뽑기
  List<Story> getStoryDates(DateTime day) {
    final story = event[day];

    if(story!=null) return [story];
    else return [];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //일기 화면 -> +버튼 일기 추가
      appBar: CustomAppBar(
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  newFormat = (newFormat == CalendarFormat.month)
                      ? CalendarFormat.week : CalendarFormat.month;
                  print('$newFormat');
              });
              },
              icon: Icon(Icons.calendar_today),
          ),
          IconButton(
              onPressed: (){
                print('story add click');
              },
              icon: Icon(Icons.add)
          ),

        ],
      ),

      backgroundColor: Colors.white,

      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            Container(
              child: CalendarWidget(

                eventLoader: (day) => getStoryDates(day),
                calendarBuilders: calendarBuilders,
                onDateSelected: (date){
                  setState(() {
                    selectedDate = date;
                  });
                },
                onFormatChanged: (format){
                  setState(() {
                    newFormat = format;
                  });
                },
                calendarFormat: newFormat,

              ),
            ),

            SizedBox(height: 10.0,),

            Expanded(
              child: buildEventTitleList(),
            ),
          ],
        ),

      ),
    );

  }


  //story 보여주는 위젯
  Widget buildEventTitleList(){
    final storyTitlesForSelectedDate = getStoryTitleForDay(selectedDate);
    final storyTextForSelectedDate = getStoryTextForDay(selectedDate);

    //event가 없을 경우
    if(storyTitlesForSelectedDate.isEmpty){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text('아직 등록된 오늘의 스토리가 없습니다.'),
      );
    }

    return Container(

    );

  }


  //날짜 도트 설정
  CalendarBuilders calendarBuilders() {
    return CalendarBuilders(
        markerBuilder: (context, date, events){
          if(events.isNotEmpty){
            return Align( //Align : 도트가 셀의 하단에 맞춰서 배치되도록
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -5),

                  child: Icon(
                    Icons.check,
                    color: Color(0xff008080),
                    size: 25.0,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black45,
                        offset : Offset(2.0, 2.0), //그림자 위치
                      )
                    ],
                  ),
                ),
            );
          }
          //event가 없는 경우 빈 위젯 반환
          return SizedBox.shrink();
        }
    );
  }
}
