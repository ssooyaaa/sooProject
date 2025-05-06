import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_http/user_http.dart';
import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../model/user_model.dart';
import '../../vo/user.dart';
import '../login_screen.dart';
import 'found_user_id_screen.dart';

class ChangeUserPwScreen extends StatefulWidget {
  const ChangeUserPwScreen({super.key});

  @override
  State<ChangeUserPwScreen> createState() => _ChangeUserPwScreenState();
}

class _ChangeUserPwScreenState extends State<ChangeUserPwScreen> {
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
        title: Text('비밀번호 찾기', style: TextStyle(color: Colors.black, fontSize: 18)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // todo 뒤로가기 로직
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FoundUserIdScreen()),
            );
          },
        ),
      ),

      body: Container(
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
                    Text('새로운 비밀번호', style: TextStyle(fontSize: 20),),
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
                        onChanged: (text) {
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
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons
                                    .visibility,
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
                        onChanged: (text) {
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
                              onPressed: () {
                                setState(() {
                                  _obscureCheckText = !_obscureCheckText;
                                });
                              },
                              icon: Icon(
                                _obscureCheckText ? Icons.visibility_off : Icons
                                    .visibility,
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
              onPressed: () async{
                //todo 로그인 창 이동'

                if (iconColor == Colors.green &&
                    iconCheckColor == Colors.green) {

                  //새로운 pw 상태관리 저장
                  User u = Provider.of<UserModel>(context, listen: false).findingUser;
                  u.pw = userPwController.text;

                  print(u.userIdx);
                  print(u.pw);

                  //todo 사용자 비밀번호 변경 API
                  var response = await UserHttp.updateUser(user: u);

                  if(response){
                    AppConfig.showToast(text: '새로운 비밀번호로 변경되었습니다.');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false, // 이전 모든 라우트를 제거
                    );

                  }
                } else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('비밀번호를 올바르게 입력해주세요.')),
                  );
              },
              child: Text('확인', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: iconColor == Colors.green &&
                    iconCheckColor == Colors.green
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
