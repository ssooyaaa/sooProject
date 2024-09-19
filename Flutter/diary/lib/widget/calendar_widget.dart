import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../config/app_colors.dart';
import '../model/event.dart';



class CalendarWidget extends StatefulWidget {

  List<dynamic> Function(DateTime day) eventLoader;
  CalendarBuilders Function() calendarBuilders;
  void Function(DateTime selectedDay) onDateSelected;
  CalendarFormat calendarFormat;
  void Function(CalendarFormat)? onFormatChanged;

  CalendarWidget({
    required this.eventLoader,
    required this.calendarBuilders,
    required this.onDateSelected,
    required this.calendarFormat,
    this.onFormatChanged,
  });


  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}



class _CalendarWidgetState extends State<CalendarWidget> {


  //선택된 날짜 관리변수
  DateTime selectedDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );

  DateTime focusedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2000,1,1),
      lastDay: DateTime(2030,12,31),
      //날짜 선택시 호출될 콜백 함수 설정
      onDaySelected: onDaySelected,
      //특정 날짜가 선택된 날짜와 동일한지 판단
      selectedDayPredicate: (date){
        return isSameDay(selectedDate, date);
      },
      focusedDay : selectedDate,
      locale: 'ko-KR',
      daysOfWeekHeight: 50,

      //달력 header
      headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.symmetric(vertical: 0),
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
      ),

      //달력 스타일
      calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.black),
          weekendTextStyle: TextStyle(color: Colors.red),
          todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          selectedTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),

          //오늘 날짜 박스
          todayDecoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.moreBasicColor, width: 3)
          ),

          //선택된 날짜 박스
          selectedDecoration: BoxDecoration(
            color: AppColors.moreBasicColor,
            shape: BoxShape.circle,
          )

      ),

      eventLoader: widget.eventLoader,

      calendarBuilders: widget.calendarBuilders(),

      calendarFormat: widget.calendarFormat,
    );
  }


  //날짜선택
  void onDaySelected(DateTime selectedDay, DateTime focusedDay){
    setState(() {
      selectedDate = selectedDay;
      focusedDate = focusedDay;
    });
    widget.onDateSelected(selectedDay);
  }
}
