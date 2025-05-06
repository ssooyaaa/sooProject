import 'package:diary/app_http/user_http.dart';
import 'package:diary/screen/find_user/change_user_pw_screen.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../model/user_model.dart';
import '../../vo/user.dart';

class FindUserPwScreen extends StatefulWidget {
  const FindUserPwScreen({super.key});

  @override
  State<FindUserPwScreen> createState() => _FindUserPwScreenState();
}

class _FindUserPwScreenState extends State<FindUserPwScreen> {

  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userIdController = TextEditingController();


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
              MaterialPageRoute(builder: (context) => LoginScreen()),
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
                    Text('번호/아이디로 찾기',style: TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextField(
                        controller: userPhoneController,
                        style: TextStyle(
                            color: Colors.black
                        ),

                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          hintText: '휴대폰 번호 (ex)+821011112222'

                        ),

                      ),


                      SizedBox(height: 20,),

                      TextField(
                        controller: userIdController,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          hintText: '아이디'

                        ),

                      ),

                    ],

                  ),

                ),

              ],
            ),
            ElevatedButton(
              onPressed: () async{
                //todo 아이디/전화번호로 찾기'

                User u = User(
                    phoneNumber : userPhoneController.text,
                    id : userIdController.text
                );

                User? result = await UserHttp.findByPhoneAndId(user: u);

                if(result!=null){
                  print(result.userIdx);

                  Provider.of<UserModel>(context, listen: false).foundUser(user: result);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeUserPwScreen(

                    )),
                  );
                }else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('번호와 아이디가 일치하지 않습니다.')),
                  );


              },
              child: Text('다음', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: userIdController.text.isNotEmpty && userPhoneController.text.isNotEmpty
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
