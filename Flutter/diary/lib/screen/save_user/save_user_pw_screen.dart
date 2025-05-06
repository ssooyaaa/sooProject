import 'package:diary/model/user_model.dart';
import 'package:diary/screen/save_user/save_user_id_screen.dart';
import 'package:diary/screen/save_user/save_user_nick_screen.dart';
import 'package:diary/vo/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';

class SaveUserPwScreen extends StatefulWidget {
  const SaveUserPwScreen({super.key});


  @override
  State<SaveUserPwScreen> createState() => _SaveUserPwScreenState();
}

class _SaveUserPwScreenState extends State<SaveUserPwScreen> {

  TextEditingController userPwController = TextEditingController();
  TextEditingController userPwCheckController = TextEditingController();
  Color iconColor = Colors.black54;
  Color iconCheckColor = Colors.black54;

  bool _obscureText = true;
  bool _obscureCheckText = true;


  //비밀번호 조건 확인
  void validatePw(){
    if(RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(userPwController.text)){
      setState(() {
        iconColor = Colors.green;
      });
    }else{
      setState(() {
        iconColor = Colors.black54;
      });
    }
  }

  //비밀번호 중복확인
  void validatePwCheck(){
    if(userPwCheckController.text == userPwController.text){
      setState(() {
        iconCheckColor = Colors.green;
      });
    }else{
      setState(() {
        iconCheckColor = Colors.black54;
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
              MaterialPageRoute(builder: (context) => SaveUserIdScreen()),
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
                    Icon(Icons.lock, size: 30,),
                    SizedBox(width: 5,),
                    Text('비밀번호',style: TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextField(
                        controller: userPwController,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        cursorColor: Colors.black,
                        onChanged: (text){
                          validatePw();
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black
                                )
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.grey[400],
                                )
                            ),

                        ),

                      ),



                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [

                            Icon(
                              Icons.check,
                              color: iconColor,
                            ),

                            SizedBox(width: 10,),

                            Text('8자리이상 숫자, 영문'),
                          ],
                        ),
                      ),

                      SizedBox(height: 30,),

                      TextField(
                        controller: userPwCheckController,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        cursorColor: Colors.black,
                        onChanged: (text){
                          validatePwCheck();
                        },
                        obscureText: _obscureCheckText,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _obscureCheckText = !_obscureCheckText;
                                });
                              },
                              icon: Icon(
                                _obscureCheckText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey[400],
                              )
                          ),

                        ),

                      ),



                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [

                            Icon(
                              Icons.check,
                              color: iconCheckColor,
                            ),

                            SizedBox(width: 10,),

                            Text('비밀번호 중복확인'),
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
                //todo 비밀번호 저장 / 닉네임 입력 창 이동'


                if(iconColor==Colors.green && iconCheckColor==Colors.green){

                  //pw 상태관리 저장
                  Provider.of<UserModel>(context, listen: false).setPw(pw: userPwController.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SaveUserNickScreen(

                    )),
                  );
                }else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('비밀번호를 올바르게 입력해주세요.')),
                  );


              },
              child: Text('다음', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: iconColor==Colors.green && iconCheckColor==Colors.green
                    ? AppColors.moreBasicColor
                    : AppColors.basicColor,
              ),
            ),
          ],
        ),

      ),
    );
  }
}
