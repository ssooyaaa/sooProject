import 'package:csh_final_app/app_http/user_http.dart';
import 'package:csh_final_app/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../vo/user.dart';
import '../widget/app_widget.dart';


class SaveUserScreen extends StatefulWidget {
  const SaveUserScreen({super.key});

  @override
  State<SaveUserScreen> createState() => _SaveUserScreenState();
}

enum DeveloperType {frontend, backend, server, app, db}

class _SaveUserScreenState extends State<SaveUserScreen> {

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  TextEditingController nickController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DeveloperType _developerType = DeveloperType.frontend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('회원가입', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //todo 아이디, 비번, 닉네임, 주소, 개발자 타입 체크, 가입 버튼

                      buildTitle(titleText: '아이디'),
                      AppInput(
                        width: double.infinity,
                        textEditingController: idController,
                        hintText: '아이디',
                      ),

                      SizedBox(height: 20,),
                      buildTitle(titleText: '비밀번호'),
                      AppInput(
                        width: double.infinity,
                        textEditingController: pwController,
                        hintText: '비밀번호',
                        isPassword: true,
                      ),

                      SizedBox(height: 10,),
                      AppInput(
                        width: double.infinity,
                        textEditingController: pwCheckController,
                        hintText: '비밀번호 확인',
                        isPassword: true,
                      ),

                      SizedBox(height: 20,),
                      buildTitle(titleText: '닉네임'),
                      AppInput(
                        width: double.infinity,
                        textEditingController: nickController,
                        hintText: '닉네임',
                      ),

                      SizedBox(height: 20,),
                      buildTitle(titleText: '주소'),
                      AppInput(
                        width: double.infinity,
                        textEditingController: addressController,
                        hintText: '주소',
                      ),


                      SizedBox(height: 20,),
                      buildTitle(titleText: '개발자 분야 선택'),
                      //todo radio 개발자 타입
                      Column(
                        children: [
                          RadioListTile(
                            activeColor: Colors.black,
                            title: Text('프론트엔드'),
                            value: DeveloperType.frontend,
                            groupValue: _developerType,
                            onChanged: (DeveloperType? value) {
                              setState(() {
                                _developerType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.black,
                            title: Text('백엔드'),
                            value: DeveloperType.backend,
                            groupValue: _developerType,
                            onChanged: (DeveloperType? value) {
                              setState(() {
                                _developerType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.black,
                            title: Text('서버'),
                            value: DeveloperType.server,
                            groupValue: _developerType,
                            onChanged: (DeveloperType? value) {
                              setState(() {
                                _developerType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.black,
                            title: Text('모바일앱'),
                            value: DeveloperType.app,
                            groupValue: _developerType,
                            onChanged: (DeveloperType? value) {
                              setState(() {
                                _developerType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.black,
                            title: Text('데이터베이스'),
                            value: DeveloperType.db,
                            groupValue: _developerType,
                            onChanged: (DeveloperType? value) {
                              setState(() {
                                _developerType = value!;
                              });
                            },
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            LongButton(
              onTap: () async{

                AppConfig.showToast(text: 'abcd');

                if(idController.text.isEmpty){
                  AppConfig.showToast(text: '아이디를 입력하세요.');
                  return;
                }

                if(pwController.text.isEmpty){
                  AppConfig.showToast(text: '패스워드를 입력하세요.');
                  return;
                }

                if(nickController.text.isEmpty){
                  AppConfig.showToast(text: '닉네임을 입력하세요.');
                  return;
                }

                if(addressController.text.isEmpty){
                  AppConfig.showToast(text: '주소를 입력하세요.');
                  return;
                }

                if(pwController.text != pwCheckController.text){
                  AppConfig.showToast(text: '비밀번호가 일치하지 않습니다.');
                  return;
                }

                print(idController.text);
                print(pwController.text);
                print(pwCheckController.text);
                print(nickController.text);
                print(addressController.text);
                print(_developerType);


                User user = User(
                  id: idController.text,
                  pw: pwController.text,
                  nick: nickController.text,
                  address: addressController.text,
                );

                var response = await UserHttp.save(user: user);

                if(response){
                  AppConfig.showToast(text: '회원가입 완료');
                }

              },
              width: double.infinity,
              child: Center(
                  child: Text('회원가입', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),)),
              backgroundColor: Colors.black,
              borderRadius: 0,
            ),

          ],
        ),
      ),
    );
  }
}



Widget buildTitle({required String titleText}){
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Text('$titleText', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
      ],
    ),
  );
}