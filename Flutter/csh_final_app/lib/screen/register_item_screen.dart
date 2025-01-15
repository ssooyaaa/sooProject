
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class RegisterItemScreen extends StatefulWidget {
  const RegisterItemScreen({super.key});

  @override
  State<RegisterItemScreen> createState() => _RegisterItemScreenState();
}

class _RegisterItemScreenState extends State<RegisterItemScreen> {

  final ImagePicker picker = ImagePicker();

  List<Widget> imagesBoxes = [

  ];

  /*final List<XFile?> images = [];
  final ImagePicker picker = ImagePicker();
  final int maxImages = 8;

  Future<void> pickImage() async{
    if(images.length >= maxImages){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('최대 $maxImages개의 이미지만 선택할 수 있습니다.')),
      );
      return;
    }

    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if(pickedImage != null){
      setState(() {
        images.add(pickedImage);
      });
    }
  }*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('중고 상품 등록'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20,),
            
            Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.start,

              children: [
                GestureDetector(
                  onTap: () async{
                    //todo 갤러리 호출
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if(image != null){
                      Uint8List fileBytes = await convertResizedUint8List(xFile: image, resizedWidth: 700);
                      imagesBoxes.add(ImageBox(bytes: fileBytes));
                      setState(() {

                      });
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
                        Text('0/8', style: TextStyle(color: Color(0xff878b94), fontWeight: FontWeight.bold, fontSize: 17),),
                      ],
                    ),
                  ),
                ),

                ...imagesBoxes



              ],
            )

          ],
        ),
      ),
    );
  }
}


class ImageBox extends StatelessWidget {
  Uint8List bytes;

  ImageBox({required this.bytes});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Color(0xffdedede))
        ),
        width: 80,
        height: 80,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(bytes, width: 80, height: 80, fit: BoxFit.cover,)),
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
