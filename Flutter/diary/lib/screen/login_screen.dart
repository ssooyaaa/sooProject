import 'package:diary/app_http/user_http.dart';
import 'package:diary/config/app_config.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/find_user/find_user_id_screen.dart';
import 'package:diary/screen/find_user/find_user_pw_screen.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:diary/screen/save_user/save_user_screen.dart';
import 'package:diary/widget/app_logo.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../vo/user.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userId = '';
  String _password = '';
  bool _obscureText = true;

  void _login() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // onSaved 실행

      //todo 로그인 백엔드 요청
      User user = User(
        id : _userId,
        pw : _password
      );

      User? result = await UserHttp.findByIdAndPw(user: user);

      //todo 자동로그인 상태관리(me)
      Provider.of<UserModel>(context, listen: false).setLoginUser(user: result);

      if(result!=null){
        //로그인 성공
        AppConfig.showToast(text: result.nick+'님 반갑습니다:)');

        //로컬 스토리지에 저장
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("login_user_idx", result.userIdx);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomWidget(bottomSelectedIdx: 0,)),
        );

      }else{
        //로그인 실패
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('아이디 또는 비밀번호가 틀렸습니다.')),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LOGIN', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              
              SizedBox(height: 50,),

              TextFormField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userId = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
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
                cursorColor: Colors.black,
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  } else if (value.length < 6) {
                    return '비밀번호는 6자 이상 입력해주세요.';
                  } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
                    return '비밀번호는 영어와 숫자를 포함해야 합니다.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _login,
                child: Text('로그인하기', style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  elevation: 0,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //todo 아이디 찾기 로직
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindUserIdScreen()),
                        );
                      },
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(color: Colors.black45, fontSize: 14),
                      ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Colors.black45, fontSize: 14),
                  ),

                  //todo 비밀번호 찾기 로직
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindUserPwScreen()),
                      );
                    },
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50,),

              ElevatedButton(
                  //todo 회원가입
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaveUserScreen()),
                    );
                  },
                  child: Text('계정이 없으신가요? 간편가입하기', style: TextStyle(fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.black, width: 0.7),
                    )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
