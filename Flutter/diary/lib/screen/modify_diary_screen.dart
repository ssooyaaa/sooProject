/*

import 'dart:typed_data';

import 'package:diary/app_http/diary_http.dart';
import 'package:diary/screen/write_diary_screen.dart';
import 'package:diary/vo/diary_img.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../config/app_config.dart';
import '../model/user_model.dart';
import '../vo/diary.dart';
import '../widget/app_widget.dart';
import 'diary_screen.dart';


class ModifyDiaryScreen extends StatefulWidget {
  int diaryIdx;

  ModifyDiaryScreen({
    required this.diaryIdx,
  });

  @override
  State<ModifyDiaryScreen> createState() => _ModifyDiaryScreenState();
}

class _ModifyDiaryScreenState extends State<ModifyDiaryScreen> {

  late Diary diary;
  late List<DiaryImg> imgs;

  late TextEditingController titleController;
  late TextEditingController textController;

  final ImagePicker picker = ImagePicker();

  List<ImageBox> imagesBoxes = [];


  int imgCount = 0;

  final storage = FirebaseStorage.instance;


  //선택된 날짜 관리변수
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );



  @override
  void initState(){
    super.initState();

    // 컨트롤러 초기화
    titleController = TextEditingController();
    textController = TextEditingController();

    getTodayDiary(widget.diaryIdx);
  }


  Future<void> getTodayDiary(int diaryIdx) async{

    var result = await DiaryHttp.getTodayDiaryAndImgs(diaryIdx: diaryIdx);

    if(result.isNotEmpty){
      diary = result[0] as Diary;
      imgs = result[1] as List<DiaryImg>;

      imgCount = imgs.length;

      setState(() {
        titleController.text = diary.title?? '';
        textController.text = diary.content?? '';

      });

    }else{
      AppConfig.showToast(text: '나중에 다시 한번 시도해주세요');
    }

  }

  @override
  void dispose() {
    // 메모리 누수를 방지하기 위해 컨트롤러 해제
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('DIARY'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(

            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildTitle(titleText: 'TODAY : ${today.year}년 ${today.month}월 ${today.day}일'),

                  SizedBox(height: 8.0,),

                  buildTitle(titleText: 'TITLE'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff878b94),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 17),
                      decoration: const InputDecoration(
                        hintText: '제목',
                        border: InputBorder.none,
                      ),
                      controller: titleController,
                    ),
                  ),

                  SizedBox(height: 30.0,),

                  buildTitle(titleText: 'PHOTOS'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,

                          children: [
                            GestureDetector(
                              onTap: () async{
                                //todo 갤러리 호출
                                final XFile? image = await picker.pickImage(source: ImageSource.gallery);


                                if(imgCount<7){
                                  if(image != null){
                                    Uint8List fileBytes = await convertResizedUint8List(xFile: image, resizedWidth: 700);

                                    imagesBoxes.add(ImageBox(
                                      isFirst: imagesBoxes.isEmpty ? true:false,
                                      bytes: fileBytes,
                                      key: GlobalKey(),
                                      onDelete: (key){
                                        imagesBoxes.removeWhere((element) => element.key==key);

                                        if(imagesBoxes.isNotEmpty){
                                          for(var i=0; i<imagesBoxes.length; i++){
                                            imagesBoxes[i].isFirst = (i==0);
                                          }
                                          //imagesBoxes.first.isFirst=true;
                                          // 디버깅: 삭제 후 리스트 상태 출력
                                          print('삭제 후 리스트 상태:');
                                          for (var i = 0; i < imagesBoxes.length; i++) {
                                            print('Index: $i, isFirst: ${imagesBoxes[i].isFirst}');
                                          }
                                        }

                                        setState((){
                                          imgCount--;
                                        });

                                      },
                                    ));

                                    setState(() {
                                      imgCount++;
                                    });

                                  }
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('등록 가능한 사진 갯수를 초과하였습니다.')),
                                  );
                                }



                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Color(0xfff878b94)),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt, color: Color(0xff878b94), size: 28,),
                                    Text('${imgCount}/7', style: TextStyle(color: Color(0xff878b94), fontWeight: FontWeight.bold, fontSize: 17),),
                                  ],
                                ),
                              ),
                            ),

                            //todo 이미지들
                            ...imagesBoxes




                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.0,),

                  buildTitle(titleText: 'CONTENT'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff878b94),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: const TextStyle(fontSize: 17),
                      minLines: 5,
                      keyboardType: TextInputType.multiline, // 여러 줄 입력 가능하도록 설정
                      maxLines: null, // 무제한 줄 입력 가능
                      decoration: const InputDecoration(
                        hintText: '오늘의 일기를 작성해주세요...',
                        border: InputBorder.none,
                      ),
                      controller: textController,
                    ),
                  ),

                ],

              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LongButton(
              //todo 버튼 저장시, 일기 저장
              //todo 저장 시, 내용 입력 체크
              onTap: () async{

                print('저장');
                List<String> imgUrlList = [];

                //todo 이미지 등록 -> firebase 업로드 -> 주소
                // Create a storage reference from our app
                final storageRef = storage.ref();
                for(ImageBox imgBox in imagesBoxes){

                  //todo 업로드 구현
                  // Create a reference to "mountains.jpg"
                  final itemRef = storageRef.child("diary_imgs/${DateTime.now().millisecond}.png");
                  //비동기방식
                  UploadTask task = itemRef.putData(imgBox.bytes);
                  //동기화
                  TaskSnapshot snapshot = await task.whenComplete((){});
                  String url = await snapshot.ref.getDownloadURL();
                  imgUrlList.add(url);

                }


                //todo diary/diary_img 업데이트
                */
/*var isSaved = await DiaryHttp.save(
                    userIdx: Provider.of<UserModel>(context, listen: false).me!.userIdx,
                    title: titleController.text,
                    content: textController.text,
                    savedDate: today.toString(),
                    imgUrlList: imgUrlList
                );

                print('isSaved');
                if(isSaved){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DiaryScreen()),
                  );
                  AppConfig.showToast(text: '오늘의 일기가 저장되었습니다');
                }else{
                  AppConfig.showToast(text: '다시 한번 시도해주세요');
                }*//*



              },
              width: double.infinity,
              child: Center(
                child: Text('오늘의 일기 저장',
                  style: TextStyle(color: Colors.black, fontSize:17, fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: AppColors.basicColor,
            ),
          ),
        ],
      ),
    );
  }
}
*/
