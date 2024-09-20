
import 'package:csh_final_app/screen/login_screen.dart';
import 'package:csh_final_app/widget/app_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void init() async{
    //1초뒤 로그인 or 메인페이지 이동
    await Future.delayed(Duration(milliseconds: 1300));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

  }


  void initState(){
    super.initState();
    init();
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
            //todo 앱로고(1초동안 로딩)
            AppLogo(width: 80,),
          ],
        ),
      ),
    );
  }
}
