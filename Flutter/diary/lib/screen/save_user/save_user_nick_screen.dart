import 'package:diary/model/user_model.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:diary/screen/save_user/save_user_pw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_config.dart';


class SaveUserNickScreen extends StatefulWidget {
  const SaveUserNickScreen({super.key});

  @override
  State<SaveUserNickScreen> createState() => _SaveUserNickScreenState();
}

class _SaveUserNickScreenState extends State<SaveUserNickScreen> {

  TextEditingController userNickController = TextEditingController();
  Color iconColor = Colors.black54;


  //닉네임 입력 확인
  void validateNick(){
    if(userNickController.text.isNotEmpty || userNickController.text!=null){
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
                MaterialPageRoute(builder: (context) => SaveUserPwScreen(

                )),
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
                      Text('닉네임',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: userNickController,
                          style: TextStyle(
                              color: Colors.black
                          ),
                          cursorColor: Colors.black,
                          onChanged: (text){
                            validateNick();
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  )
                              )
                          ),

                        ),



                      ],

                    ),

                  ),

                ],
              ),
              ElevatedButton(
                onPressed: () async{
                  //todo 닉네임 저장 / 로그인 창 이동'

                  if(iconColor==Colors.green){
                    var user = Provider.of<UserModel>(context, listen: false).setNick(nick: userNickController.text);

                    var response = await UserModel().saveUser(user: user);

                    if(response){
                      AppConfig.showToast(text: '회원가입 완료');

                      //회원가입 정보 reset
                      Provider.of<UserModel>(context, listen: false).resetSavingUser();

                      //회원가입 후에는 지금까지의 스택에 있는 화면 모두 삭제(pop)
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false, // 이전 모든 라우트를 제거
                      );

                    }

                  }else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('닉네임을 입력해주세요.')),
                    );


                },
                child: Text('가입하기', style: TextStyle(fontWeight: FontWeight.bold),),
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
