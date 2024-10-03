import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/rountine_list_screen.dart';
import 'package:flutter/material.dart';

import '../widget/app_widget.dart';


class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}


class _WriteDiaryScreenState extends State<WriteDiaryScreen> {

  //선택된 날짜 관리변수
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );


  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('DIARY'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),

        child: Column(
          children: [

            buildTitle(titleText: 'TODAY : ${today.year}년 ${today.month}월 ${today.day}일'),

            SizedBox(height: 8.0,),

            buildTitle(titleText: 'TITLE'),
            AppInput(
              width: double.infinity,
              textEditingController: titleController,
              hintText: '제목',
            ),

            SizedBox(height: 24.0,),

            buildTitle(titleText: 'CONTENT'),
            Expanded(
              child: buildText(
                  controller: textController,
                  hintText: '오늘의 일기를 작성해주세요...',
                  line: null
              ),
            ),

            SizedBox(height: 32.0,),

            LongButton(
              //todo 버튼 저장시, 일기 저장
              //todo 저장 시, 내용 입력 체크
              onTap: (){
                print('일기 저장');
                print(textController.text==''? 'true':'false');
              },
              width: double.infinity,
              child: Center(
                child: Text('오늘의 일기 저장',
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
    padding: EdgeInsets.only(bottom: 18.0),
    child: Row(
      children: [
        Text('$titleText', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      ],
    ),
  );
}



class buildText extends StatelessWidget {

  TextEditingController controller;
  String hintText;
  int? line;

  buildText({
    required this.controller,
    required this.hintText,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: line,
      keyboardType: TextInputType.multiline,
      scrollPhysics: BouncingScrollPhysics(),
      decoration: InputDecoration(
        hintText: '$hintText',
        border: OutlineInputBorder(),
      ),
    );
  }
}

