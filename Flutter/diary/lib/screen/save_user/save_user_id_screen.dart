import 'package:diary/app_http/user_http.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/save_user/save_user_phone_screen.dart';
import 'package:diary/screen/save_user/save_user_pw_screen.dart';
import 'package:diary/screen/save_user/save_user_screen.dart';
import 'package:diary/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../vo/user.dart';


class SaveUserIdScreen extends StatefulWidget {
  const SaveUserIdScreen({super.key});

  @override
  State<SaveUserIdScreen> createState() => _SaveUserIdScreenState();
}

class _SaveUserIdScreenState extends State<SaveUserIdScreen> {

  TextEditingController userIdController = TextEditingController();
  Color iconColor = Colors.black54;
  Color iconIdCheckColor = Colors.black54;



  //아이디 조건 확인
  //todo 아이디 조건(사용 가능한 아이디 체크)
  void validateId(){
    if(RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,30}$').hasMatch(userIdController.text)){
      setState(() {
        iconColor = Colors.green;
      });
    }else{
      setState(() {
        iconColor = Colors.black54;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('JOIN', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // todo 뒤로가기 로직
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SaveUserPhoneScreen()),
            );

          },
        ),
      ),

      body:Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 30,),
                    SizedBox(width: 5,),
                    Text('아이디',style: TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: userIdController,
                        style: TextStyle(
                          color: Colors.black
                        ),
                        cursorColor: Colors.black,
                        onChanged: (text){
                          validateId();
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          ),
                          suffixIcon: TextButton(
                              onPressed: () async{
                                //todo 아이디 중복확인
                                User? result = await UserHttp.findById(userId: userIdController.text);

                                if(result==null){
                                  setState(() {
                                    iconIdCheckColor = Colors.green;
                                  });
                                }else{

                                  setState(() {

                                    iconIdCheckColor = Colors.black54;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('아이디를 사용하실 수 없습니다.')),
                                    );

                                  });


                                }



                              },
                              child: Text('확인',
                                style: TextStyle(color: Colors.black),
                              ),
                          ),

                        ),

                      ),



                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [

                                Icon(
                                  Icons.check,
                                  color: iconColor,
                                ),

                                SizedBox(width: 10,),

                                Text('5~30자리 숫자, 영문'),
                              ],
                            ),

                            SizedBox(height: 10,),

                            Row(
                              children: [

                                Icon(
                                  Icons.check,
                                  color: iconIdCheckColor,
                                ),

                                SizedBox(width: 10,),

                                Text('아이디 중복확인'),
                              ],
                            ),

                          ],
                        ),
                      ),


                    ],

                  ),

                ),

              ],
            ),
            ElevatedButton(
              onPressed: (){
                //todo 아이디 저장 / 비밀번호 입력 창 이동'

                if(iconIdCheckColor!=Colors.green){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('아이디 확인을 눌러주세요.')),
                  );
                }else{
                  if(iconColor==Colors.green){

                    //id 상태관리 세팅
                    Provider.of<UserModel>(context, listen: false).setId(id: userIdController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaveUserPwScreen()),
                    );
                  }else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('아이디를 올바르게 입력해주세요.')),
                    );

                }


              },
              child: Text('다음', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: iconColor==Colors.green
                    ? AppColors.moreBasicColor
                    : AppColors.basicColor,
              ),
            ),
          ],
        ),

      )

    );
  }
}
