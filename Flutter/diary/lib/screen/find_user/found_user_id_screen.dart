import 'package:diary/config/app_colors.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/find_user/change_user_pw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_screen.dart';

class FoundUserIdScreen extends StatefulWidget {
  const FoundUserIdScreen({super.key});

  @override
  State<FoundUserIdScreen> createState() => _FoundUserIdScreenState();
}

class _FoundUserIdScreenState extends State<FoundUserIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
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
                  
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Consumer<UserModel>(builder: (context, userModel, child){
                          return RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(text: '고객님의 아이디는 '),
                                  TextSpan(
                                      text: '${userModel.findingUser.id}',
                                      style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)
                                  ),
                                  TextSpan(text: ' 입니다.'),
                                ]
                              )
                          );
                        }),

                        SizedBox(height: 30,),
                        //todo 비밀번호 찾기 로직
                        TextButton(
                          onPressed: (){

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChangeUserPwScreen()),
                            );
                          },

                          child: Text(
                            '비밀번호 찾기',
                            style: TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                        ),

                      ],

                    ),

                  ),

                ],
              ),
              ElevatedButton(
                onPressed: () async{
                  //todo 로그인 창 이동
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false, // 이전 모든 라우트를 제거
                  );
                },
                child: Text('확인', style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  elevation: 0,
                  backgroundColor: AppColors.moreBasicColor,
                ),
              ),
            ],
          ),

        )

    );
  }

}
