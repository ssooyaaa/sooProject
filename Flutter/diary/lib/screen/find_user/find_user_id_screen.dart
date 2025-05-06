import 'dart:async';

import 'package:diary/screen/find_user/found_user_id_screen.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_http/user_http.dart';
import '../../config/app_colors.dart';
import '../../model/user_model.dart';
import '../../vo/user.dart' as U;

class FindUserIdScreen extends StatefulWidget {
  const FindUserIdScreen({super.key});

  @override
  State<FindUserIdScreen> createState() => _FindUserIdScreenState();
}

class _FindUserIdScreenState extends State<FindUserIdScreen> {

  final _key = GlobalKey<FormState>();

  TextEditingController userPhoneController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();

  bool _codeSent = false;
  String _verificationId = '';

  int remainingTime = 120;
  Timer? timer;

  Color iconColor = Colors.black54;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('아이디 찾기',
              style: TextStyle(color: Colors.black, fontSize: 18)
          ),
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
                      Icon(Icons.phone_android, size: 30,),
                      SizedBox(width: 5,),
                      Text('SMS인증',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: Form(
                      key: _key,
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
                              hintText: '+821011112222',
                              suffixIcon: TextButton(
                                onPressed: () async{

                                  //todo 번호 확인
                                  U.User? result = await UserHttp.findByPhoneNumber(phoneNumber: userPhoneController.text);

                                  if(result==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('등록되어있지 않는 번호입니다.')),
                                    );
                                  }else{
                                    //todo SMS 인증버튼

                                    if(_key.currentState!.validate()){
                                      FirebaseAuth auth = FirebaseAuth.instance;

                                      await auth.verifyPhoneNumber(
                                          phoneNumber: userPhoneController.text,
                                          verificationCompleted: (PhoneAuthCredential credential) async{
                                            //Android only
                                            await auth
                                                .signInWithCredential(credential);
                                          },
                                          verificationFailed: (FirebaseAuthException e){
                                            if(e.code == 'invalid-phone-number'){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('유효하지 않은 번호입니다.')),
                                              );
                                            }
                                          },
                                          codeSent: (String verificationId, forceResendingToken) async{
                                            setState(() {
                                              _codeSent = true;
                                              _verificationId = verificationId;
                                              remainingTime = 120;
                                              startCountdown();
                                            });
                                          },
                                          codeAutoRetrievalTimeout: (verificationId){
                                            print('코드 입력 시간이 초과되었습니다.');
                                          }
                                      );
                                    }

                                  }

                                },
                                child: Text('인증하기',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),

                            ),

                          ),

                          SizedBox(height: 40,),
                          _codeSent ? Row(
                            children: [
                              Expanded(
                                  child: smsCodeInput()
                              ),
                              SizedBox(width: 15,),
                              Text('${formatTime(remainingTime)}',
                                  style: TextStyle(fontSize: 16)
                              ),
                              SizedBox(width: 10,)
                            ],
                          ) : SizedBox.shrink(),


                          SizedBox(height: 20,),


                        ],

                      ),
                    ),

                  ),

                ],
              ),
              ElevatedButton(
                onPressed: (){
                  //todo 아이디 확인 창 이동'
                  if(iconColor==Colors.green){

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaveUserIdScreen()),
                    );*/
                  }else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('휴대폰 인증 확인해주세요.')),
                    );


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


  TextFormField smsCodeInput(){
    return TextFormField(
      controller: smsCodeController,
      autofocus: true,
      style: TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.black,

      validator: (val){
        if(val!.isEmpty){
          return '코드를 입력해주세요';
        }else
          return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black
            )
        ),
        suffixIcon: TextButton(
          onPressed: () async{

            try{
              FirebaseAuth auth = FirebaseAuth.instance;

              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: _verificationId,
                  smsCode: smsCodeController.text
              );

              await auth
                  .signInWithCredential(credential);

              //현재 사용자 가져오기
              User? user = auth.currentUser;

              if(user != null){
                String uid = user.uid;

                //todo 찾은 user 상태관리
                U.User? u = await UserHttp.findByPhoneNumber(phoneNumber: userPhoneController.text);

                Provider.of<UserModel>(context, listen: false).foundUser(user: u);

              }else{
                print('사용자 인증X');
              }

              await auth.signOut();

              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('인증이 완료되었습니다.')),
                );
                timer?.cancel();
                iconColor = Colors.green;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoundUserIdScreen()),
                );

              });
            }catch(e){
              print('인증 오류 : $e');
            }




          },
          child: Text('확인',
            style: TextStyle(color: Colors.black),

          ),
        ),


      ),


    );
  }

  void startCountdown(){
    if(timer?.isActive ?? false) return;

    timer = Timer.periodic(Duration(seconds: 1), (timer){

      if(remainingTime>0){
        remainingTime--;

      }else{
        timer.cancel(); //타이머 종료
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('시간 초과되었습니다. 다시 인증해주세요.')),
        );
        setState(() {
          _codeSent = false;
        });
      }

      if(mounted)
        setState(() {

        });
    });
  }

  String formatTime(int seconds){

    int minutes = seconds ~/60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';

  }
}
