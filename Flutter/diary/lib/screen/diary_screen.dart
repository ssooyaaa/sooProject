import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:diary/app_http/diary_http.dart';
import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/modify_diary_screen.dart';
import 'package:diary/vo/diary.dart';
import 'package:diary/vo/diary_img.dart';
import 'package:diary/vo/story.dart';
import 'package:diary/screen/today_routine_screen.dart';
import 'package:diary/screen/write_diary_screen.dart';
import 'package:diary/widget/app_bar.dart';
import 'package:diary/widget/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/user_model.dart';
import '../vo/event.dart';
import '../widget/floating_button.dart';

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

  //오늘날짜
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );


  //달력 format
  CalendarFormat newFormat = CalendarFormat.month;


  late DateTime startDate;
  late DateTime endDate;

  late int loginIdx;
  late List<Diary> monthDiaryList = []; //초기 빈 리스트로 설정해두어야함.
  bool isLoading = true;

  Map<DateTime, List<Story>> stories = {};

  @override
  void initState(){
    super.initState();

    loginIdx = Provider.of<UserModel>(context, listen: false).me!.userIdx;

    initializeDiaryList(selectedDate);
  }

  Future<void> initializeDiaryList(DateTime date) async{
    DateTime startDate = DateTime.utc(date.year, date.month-1, date.day);
    DateTime endDate = DateTime.utc(date.year, date.month+1, date.day);


    monthDiaryList = await DiaryHttp.getMonthlyDiary(startDate: startDate, endDate: endDate, userIdx: loginIdx);

    var dateFormat = DateFormat('yyyy-MM-dd');

    stories.clear();

    for(var one in monthDiaryList){
      String date = dateFormat.parse(one.savedDate).toString().substring(0,10);
      List<String> dateParts = date.split('-');

      DateTime savedDate = DateTime.utc(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2])
      );

      String title = one.title;
      String imgUrl = one.imgUrl;
      String content = one.content;
      int diaryIdx = one.diaryIdx;
      List<DiaryImg> diaryImgList = await DiaryHttp.getDiaryImgs(diaryIdx: diaryIdx, createdDate: savedDate);

      Story story = Story(title: title, imgUrl: imgUrl, content: content, diaryIdx: diaryIdx, imgList: diaryImgList);

      if(stories[savedDate] == null){
        stories[savedDate] = [story];
      }else
        stories[savedDate]!.add(story);
    }

    setState(() {
      isLoading = false;
    });
  }

  //story가 있는 날짜만 뽑기
  List<Story> getStoryDates(DateTime day) {

    return stories[day]?.toList()??[];
  }

  //story title만 뽑기
  String getStoryTitleForDay(DateTime day){
    final eventsForDay = getStoryDates(day);
    return (eventsForDay != null && eventsForDay.isNotEmpty) ? eventsForDay.first.title : '';
  }

  //story content 뽑기
  String getStoryContentForDay(DateTime day){
    final eventsForDay = getStoryDates(day);
    return (eventsForDay != null && eventsForDay.isNotEmpty) ? eventsForDay.first.content : '';
  }

  //story img 뽑기
  String getStoryImgForDay(DateTime day){
    final eventsForDay = getStoryDates(day);
    return (eventsForDay != null && eventsForDay.isNotEmpty) ? eventsForDay.first.imgUrl : '';
  }

  //story imgList뽑기
  List<DiaryImg> getStoryImgsForDay(DateTime day){
    final eventsForDay = getStoryDates(day);
    return (eventsForDay != null && eventsForDay.isNotEmpty) ? eventsForDay.first.imgList : [];
  }

  //story idx뽑기
  int getStoryIdxForDay(DateTime day){
    final eventsForDay = getStoryDates(day);
    return (eventsForDay != null && eventsForDay.isNotEmpty) ? eventsForDay.first.diaryIdx : 0;
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
                });
              },
              //아이콘 변경
              icon: Icon(
                newFormat == CalendarFormat.month
                  ? Icons.zoom_in_map
                  : Icons.zoom_out_map,
              ),
          ),
          IconButton(
              onPressed: (){
                if(getStoryTitleForDay(today).isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('하루 1개씩만 작성할 수 있습니다.')),
                  );
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WriteDiaryScreen(diaryIdx: 0,)),
                  );
                }

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
                onPageChanged: (focusedDate){
                  setState(() {
                    selectedDate = focusedDate;

                    initializeDiaryList(selectedDate);
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

      //todo 오늘의 다이어리 수정/저장
      floatingActionButton: FloatingButton(
        onScreenSelected: (context){
          if(getStoryIdxForDay(today)!=0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WriteDiaryScreen(diaryIdx: getStoryIdxForDay(today))),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('작성된 오늘의 일기가 없습니다.')),
            );
          }

        },
        buttonText: 'TODAY',
      ),
    );

  }


  //story 보여주는 위젯
  Widget buildEventTitleList(){
    final storyTitlesForSelectedDate = getStoryTitleForDay(selectedDate);
    final storyContentForSelectedDate = getStoryContentForDay(selectedDate);
    final storyImgUrlForSelectedDate = getStoryImgForDay(selectedDate);
    final storyImgsUrlListForSelectedDate = getStoryImgsForDay(selectedDate);

    //story 없을 경우
    if(storyTitlesForSelectedDate.isEmpty){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text('아직 등록된 오늘의 스토리가 없습니다.'),
      );
    }

    //story가 있는 경우
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.basicColor,
            padding: EdgeInsets.all(16.0),
            child: Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0,),
          Expanded(
            child: SingleChildScrollView(
              child:Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('" $storyTitlesForSelectedDate "', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, ),),
                    SizedBox(height: 20,),
                    Text('$storyContentForSelectedDate'),
                    SizedBox(height: 20,),

                    newFormat == CalendarFormat.month
                      ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          '$storyImgUrlForSelectedDate',
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.width*0.8,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // 이미지가 다 로드되면 그대로 표시
                            }
                            return Center(
                              child: CircularProgressIndicator(), // 로딩 중에는 로딩 인디케이터 표시
                            );
                          },
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Icon(Icons.error, size: 50, color: Colors.red); // 이미지 로드 실패 시 아이콘 표시
                          },
                        ),
                      )
                     :  //todo 이미지 여러개 보여주기!!
                        slider.CarouselSlider(
                          items: storyImgsUrlListForSelectedDate.map((imageUrl) {
                            return Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Image.network(
                                  imageUrl.imgUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: MediaQuery.of(context).size.width*0.9,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // 이미지가 다 로드되면 그대로 표시
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(), // 로딩 중에는 로딩 인디케이터 표시
                                    );
                                  },
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return Icon(Icons.error, size: 50, color: Colors.red); // 이미지 로드 실패 시 아이콘 표시
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          options: slider.CarouselOptions(
                            height: 300, // 슬라이드의 높이 설정
                            enlargeCenterPage: true, // 중앙에 크게 보이도록 설정
                            autoPlay: true, // 자동 재생 설정
                            autoPlayInterval: Duration(seconds: 3), // 슬라이드 간의 간격 설정
                            autoPlayAnimationDuration: Duration(milliseconds: 800), // 애니메이션 속도 설정
                            enableInfiniteScroll: true, // 무한 스크롤 활성화
                            viewportFraction: 0.8, // 보이는 슬라이드의 비율 설정
                          ),
                        )

                  ],
                )
              ),
            ),
          ),

        ],
      ),
    );

  }


  //날짜 도트 설정
  CalendarBuilders calendarBuilders() {
    return CalendarBuilders(
        markerBuilder: (context, date, events){
          if(events.isNotEmpty){
            return Align( //Align : 도트가 셀의 상단에 맞춰서 배치되도록
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -5),

                  child: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 20.0,
                    /*shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.black45,
                        offset : Offset(2.0, 2.0), //그림자 위치
                      )
                    ],*/
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
