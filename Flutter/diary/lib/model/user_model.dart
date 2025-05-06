

import 'package:diary/app_http/user_http.dart';
import 'package:diary/vo/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier{

  //회원가입
  User savingUser = User();

  //자동로그인
  User? me;

  //아이디찾기
  User findingUser = User();


  //todo 0.회원가입 uid & 번호 저장
  void setUidAndPhone({required String uid, required String phoneNumber}){
    savingUser.uid = uid;
    savingUser.phoneNumber = phoneNumber;

    notifyListeners();
  }


  //todo 1.회원가입 아이디 저장
  void setId({required String id}){
    savingUser.id = id;

    notifyListeners();
  }

  //todo 2.회원가입 패스워드 저장
  void setPw({required String pw}){
    savingUser.pw = pw;

    notifyListeners();
  }

  //todo 3.회원가입 닉네임 저장
  User setNick({required String nick}){
    savingUser.nick = nick;

    notifyListeners();

    return savingUser;
  }

  //todo 4.회원가입 저장/API
  Future<bool> saveUser({required User user}) async{

    var response = await UserHttp.save(user: user);
    return response;
  }

  //todo 5.새로운 가입을 위한 reset
  void resetSavingUser(){
    savingUser = User();
    notifyListeners();
  }


  //todo 자동로그인
  void setLoginUser({required User? user}){
    me = user;

    notifyListeners();
  }

  //todo 로그아웃
  void logout(){
    me = null;

    notifyListeners();
  }

  //todo 아이디 찾기
  void foundUser({required User? user}){
    findingUser = user!;

    notifyListeners();
  }

  //todo 새로운 비밀번호로 변경
  void resetPw({required User? user}){
    findingUser = user!;

    notifyListeners();
  }

}