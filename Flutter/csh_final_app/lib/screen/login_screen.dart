import 'package:csh_final_app/app_http/user_http.dart';
import 'package:csh_final_app/config/app_color.dart';
import 'package:csh_final_app/config/app_config.dart';
import 'package:csh_final_app/model/user_model.dart';
import 'package:csh_final_app/screen/home_screen.dart';
import 'package:csh_final_app/screen/save_user_screen.dart';
import 'package:csh_final_app/widget/app_logo.dart';
import 'package:csh_final_app/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../vo/user.dart';


class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(width: 80,),
            Text('로그인', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),

            SizedBox(height: 10,),

            AppInput(
                width: 300,
                textEditingController: idController,
                hintText: '아이디',
            ),

            SizedBox(height: 10,),

            AppInput(
              width: 300,
              textEditingController: pwController,
              hintText: '비밀번호',
              isPassword: true,
            ),

            SizedBox(height: 20,),

            LongButton(
                onTap: () async{
                  //todo 로그인 요청

                  //1. 백엔드 요청
                  User user = User(
                    id : idController.text,
                    pw : pwController.text
                  );

                  User? result = await UserHttp.findByIdAndPw(user: user);

                  //2. 받은 user 상태관리 세팅(me)
                  Provider.of<UserModel>(context,listen:false).setLoginUser(user: result);

                  if(result!=null){
                    //로그인 성공
                    AppConfig.showToast(text: '로그인 성공');

                    //로컬 스토리지에 저장
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setInt("login_user_idx", result.userIdx);



                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );


                  }else{
                    //로그인 실패
                    AppConfig.showToast(text: '로그인 실패');

                  }

                },

                width: 300,
                child: Center(
                    child: Text('로그인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),)),
                backgroundColor: Colors.black,
            ),

            SizedBox(height: 10,),

            LongButton(
              onTap: (){
                //todo 회원가입이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveUserScreen()),
                );
              },
              width: 300,
              child: Center(
                  child: Text('회원가입', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 17),)),
              backgroundColor: Colors.grey.shade200,
            )

          ],
        ),
      ),
    );
  }
}
