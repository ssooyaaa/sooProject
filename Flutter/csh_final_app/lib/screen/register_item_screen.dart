import 'package:flutter/material.dart'
;
import 'package:image_picker/image_picker.dart';

class RegisterItemScreen extends StatefulWidget {
  const RegisterItemScreen({super.key});

  @override
  State<RegisterItemScreen> createState() => _RegisterItemScreenState();
}

class _RegisterItemScreenState extends State<RegisterItemScreen> {

  final List<XFile?> images = [];
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
  }



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
                  onTap: (){
                    //todo 갤러리 호출
                    pickImage();
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

                Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
