import 'dart:typed_data';

import 'package:diary/app_http/diary_http.dart';
import 'package:diary/app_http/youtube_http.dart';
import 'package:diary/config/app_colors.dart';
import 'package:diary/config/app_config.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/diary_screen.dart';
import 'package:diary/screen/rountine_list_screen.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../vo/diary.dart';
import '../vo/diary_img.dart';
import '../widget/app_widget.dart';


class ImageBoxModel{
  Uint8List? bytes;
  GlobalKey key;
  String? imgUrl;
  String? storageRefer;

  ImageBoxModel({
    this.bytes,
    required this.key,
    this.imgUrl,
    this.storageRefer,
  });
}


class WriteDiaryScreen extends StatefulWidget {

  int diaryIdx;

  WriteDiaryScreen({super.key, required this.diaryIdx});

  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}


class _WriteDiaryScreenState extends State<WriteDiaryScreen> {

  final ImagePicker picker = ImagePicker();

  List<ImageBoxModel> imagesBoxes = [];
  List<GlobalKey> keys = [];
  int imgCount = 0;

  final storage = FirebaseStorage.instance;

  late Diary diary;
  late List<DiaryImg> imgs;


  //선택된 날짜 관리변수
  DateTime today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
  );


  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

/*
  late final WebViewController webController;
  String? savedUrl;*/


  TextEditingController urlController = TextEditingController();
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
/*
    //_loadSavedUrl();

    // WebViewController 초기화
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // JavaScript 허용
      //..setBackgroundColor(Colors.white) // 배경색 설정
      ..loadRequest(Uri.parse('https://www.youtube.com')); // 초기 URL 로드

  */
  }

/*

  // SharedPreferences에서 저장된 URL 불러오기
  Future<void> _loadSavedUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedUrl = prefs.getString('savedUrl');
    });
  }

  // 현재 URL 가져와서 저장하기
  Future<void> _saveCurrentUrl() async {
    final currentUrl = await webController.currentUrl(); // 현재 URL 가져오기
    if (currentUrl != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUrl', currentUrl);
      setState(() {
        savedUrl = currentUrl;
      });
    }
  }
*/



  void init() async{

    if(widget.diaryIdx>0){
      //todo 작성된 diary 가져오기

      var result = await DiaryHttp.getTodayDiaryAndImgs(diaryIdx: widget.diaryIdx);

      if(result.isNotEmpty){
        diary = result[0] as Diary;
        imgs = result[1] as List<DiaryImg>;


        imgCount = imgs.length;

        setState(() {
          titleController.text = diary.title?? '';
          textController.text = diary.content?? '';
          url = diary.songUrl?? '';

          if(imgs.length>0){
            for(int i=0;i<imgs.length;i++){
              imagesBoxes.add(ImageBoxModel(key: GlobalKey(), imgUrl: imgs[i].imgUrl, storageRefer: imgs[i].storageRefer));
            }
          }


        });

      }else{
        AppConfig.showToast(text: '나중에 다시 한번 시도해주세요');
      }
    }
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
                        child: //todo 상세 이미지.
                        Wrap(
                          spacing: 10,
                          children: [
                            // 이미지 추가 버튼
                            GestureDetector(
                              onTap: () async {
                                if(imgCount<7){
                                  XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    Uint8List bytes = await convertResizedUint8List(xFile: image, resizedWidth: 700);
                                    setState(() {
                                      imagesBoxes.add(ImageBoxModel(bytes: bytes, key: GlobalKey()));
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
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Icon(Icons.camera_alt, color: Color(0xff878b94), size: 28,),
                                    Text('${imgCount}/7', style: TextStyle(color: Color(0xff878b94), fontWeight: FontWeight.bold, fontSize: 17),),
                                  ],
                                ),
                              ),
                            ),

                            // 이미지 리스트
                            ...imagesBoxes.asMap().entries.map((entry) {
                              int index = entry.key;
                              ImageBoxModel box = entry.value;

                              return ImageBox(
                                key: box.key,
                                bytes: box.bytes,
                                imgUrl: box.imgUrl,
                                storageRefer: box.storageRefer,
                                isFirst: index == 0,
                                onDelete: () {
                                  print('삭제');
                                  setState(() {
                                    imagesBoxes.removeAt(index);
                                    imgCount--;
                                  });
                                },
                              );
                            }).toList(),
                          ],
                        ),

                        /*Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                        
                          children: [
                            GestureDetector(
                              onTap: () async{
                                print('확인');

                                if(imgCount<7){

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

                          ],
                        ),*/
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

                  //todo youtube 노래선택
                  //webView는 크기 조정 필요

                  SizedBox(height: 40.0,),

                  buildTitle(titleText: 'SONG', bottomHeight: 5.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 17),
                          decoration: const InputDecoration(
                            hintText: '오늘을 표현하는 노래 (ex) 이무진-청춘만화)',
                          ),
                          controller: urlController,
                        ),
                      ),
                      IconButton(
                          onPressed: () async{

                            if(urlController.text.isEmpty){
                              url = '';
                            }else{
                              String searchText = urlController.text + " 음원";
                              url = await YoutubeHttp.selectYoutubeVideo(searchText);
                            }
                            print('url:$url');
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.search),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),
                  Text('YouTube URL : $url'),

                  /*IconButton(
                    icon: Icon(Icons.save),
                    onPressed: _saveCurrentUrl, // URL 저장
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Saved URL: ${savedUrl ?? "No URL saved"}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),*/

                  /*SizedBox(
                    height: 300,
                    child: WebViewWidget(
                      controller: webController,
                    ),
                  ),*/


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

                if(titleController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('제목을 입력하세요')),
                  );
                }

                if(textController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('내용을 입력하세요')),
                  );
                }

                List<String> imgUrlList = [];
                List<String> storageRefList = [];

                //todo 이미지 등록 -> firebase 업로드 -> 주소
                // Create a storage reference from our app
                final storageRef = storage.ref();


                //todo 로딩창 표시
                showLoadingDialog(context);

                try{

                  for(ImageBoxModel imgBox in imagesBoxes){

                    //todo 업로드 구현

                    //todo firebase 덮어쓰기 코드
                    String filePath;
                    if(imgBox.storageRefer != null){
                      //기존 파일 경로 사용하여 덮어쓰기
                      filePath = imgBox.storageRefer!;
                    }else{
                      //새 파일 경로 생성
                      filePath = "diary_imgs/${DateTime.now()}-${DateTime.now().millisecond}.png";
                    }

                    final itemRef = storageRef.child(filePath);
                    if(imgBox.bytes != null){
                      UploadTask task = itemRef.putData(imgBox.bytes!);
                      //동기화
                      TaskSnapshot snapshot = await task.whenComplete((){});
                      String url = await snapshot.ref.getDownloadURL();
                      imgUrlList.add(url);
                      storageRefList.add(filePath);

                    }else if(imgBox.imgUrl != null){
                      //기존 이미지
                      imgUrlList.add(imgBox.imgUrl!);
                      storageRefList.add(imgBox.storageRefer!);

                    }

                  }

                  bool isSaved;

                  //todo diary/diary_img 저장
                  if(widget.diaryIdx>0){

                    isSaved = await DiaryHttp.modifyTodayDiary(
                      diaryIdx: widget.diaryIdx,
                      userIdx: Provider.of<UserModel>(context, listen: false).me!.userIdx,
                      title: titleController.text,
                      content: textController.text,
                      savedDate: today.toString(),
                      imgUrlList: imgUrlList,
                      storageRefList: storageRefList,
                      songUrl: url
                    );

                  }else{
                    isSaved = await DiaryHttp.save(
                      userIdx: Provider.of<UserModel>(context, listen: false).me!.userIdx,
                      title: titleController.text,
                      content: textController.text,
                      savedDate: today.toString(),
                      imgUrlList: imgUrlList.isNotEmpty ? imgUrlList:[],
                      storageRefList: storageRefList.isNotEmpty ? storageRefList:[],
                      songUrl: url,
                    );
                  }

                  hideLoadingDialog(context);

                  if(isSaved){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomWidget(bottomSelectedIdx: 1)),
                    );
                    AppConfig.showToast(text: widget.diaryIdx > 0
                        ? '오늘의 일기가 수정되었습니다'
                        : '오늘의 일기가 저장되었습니다'
                    );
                  }else{
                    print('error:$imgUrlList');
                    AppConfig.showToast(text: '다시 시도해주세요');
                  }


                }catch(e){

                  hideLoadingDialog(context);
                  AppConfig.showToast(text: '오류가 발생했습니다. 다시 시도해주세요');
                }

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



Widget buildTitle({required String titleText, double bottomHeight = 18.0}){
  return Padding(
    padding: EdgeInsets.only(bottom: bottomHeight),
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
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xfff878b94)
          )
        ),
      ),
    );
  }
}



class ImageBox extends StatelessWidget {

  Uint8List? bytes;
  String? imgUrl;
  String? storageRefer;
  VoidCallback onDelete;
  bool isFirst;

  ImageBox({
    Key? key,
    this.bytes,
    this.imgUrl,
    this.storageRefer,
    required this.onDelete,
    required this.isFirst,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    border: Border.all(width: 1, color: Color(0xffdedede))
    ),
    width: 80,
    height: 80,
        child: Stack(
            children: [
              if(bytes != null)
                Image.memory(bytes!, width: 80, height: 80, fit: BoxFit.cover,)
              else if(imgUrl != null)
                Image.network(imgUrl!, width: 80, height: 80, fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                ),

              Positioned(
                    bottom: 2,
                    right: 1,
                    child: GestureDetector(
                        onTap: (){
                          onDelete();
                        },
                        child: Icon(Icons.remove_circle, color: AppColors.moreBasicColor,)
                    ),
                ),

              //대표사진 체크
              if (isFirst)
                Positioned(
                  top: 4,
                  left: 2,
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(
                      child: Text('대표', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                  ),
                ),
            ]
        ),
    );

  }
}




///XFile -> 리사이즈(축소) Uint8List
Future<Uint8List> convertResizedUint8List({required XFile? xFile, required int resizedWidth}) async{

  // XFile을 Uint8List로 변환
  Uint8List? bytes = await xFile!.readAsBytes();

  // Image 패키지를 사용하여 이미지 로드
  img.Image _image = img.decodeImage(Uint8List.fromList(bytes))!;


  //todo 사이즈 축소 (resize)
  // 이미지 리사이즈
  var h = (_image.height * resizedWidth)/ _image.width;
  img.Image resizedImage = img.copyResize(_image, width: resizedWidth, height: h.toInt());

  //todo f -> base64
  // 리사이즈된 이미지를 Uint8List로 변환
  Uint8List resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

  return resizedBytes;
}


//로딩창 띄우기
void showLoadingDialog(BuildContext context){
  showDialog(
      context: context,
      barrierDismissible: false,//사용자가 로딩창 닫지X
      builder: (BuildContext context){
        return Dialog(
          insetPadding: EdgeInsets.zero, // 기본 패딩 제거
          backgroundColor: Colors.transparent, // 배경색을 투명하게
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5), // 원하는 배경색 설정
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20), // 간격 추가
                Text(
                  '저장 중이니 잠시만 기다려주세요...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }
  );
}

//현재 로딩창 닫기
void hideLoadingDialog(BuildContext context){
  Navigator.of(context, rootNavigator: true).pop();
}