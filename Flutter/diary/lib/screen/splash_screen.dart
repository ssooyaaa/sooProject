import 'package:diary/app_http/user_http.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:diary/widget/app_logo.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../vo/user.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    init();
  }

  //todo 1초뒤 로그인 or 메인페이지 이동
  void init() async{
    await Future.delayed(Duration(microseconds: 1300));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int loginUserIdx = prefs.getInt("login_user_idx") ?? 0;


    if(loginUserIdx == 0){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }else{

      User? u = await UserHttp.findByIdx(idx: loginUserIdx);

      Provider.of<UserModel>(context,listen: false).setLoginUser(user: u);


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomWidget(bottomSelectedIdx: 0,)),
      );
    }
  }


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
            //todo 로고(1초동안 로딩)
            AppLogo(width: 150,),
          ],
        ),
      ),
    );
  }
}
