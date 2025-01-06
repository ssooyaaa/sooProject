

import 'package:csh_final_app/app_http/user_http.dart';
import 'package:csh_final_app/vo/user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{

  User? me;
  List<User> usersInTab = [];

  //상세페이지 - 회원
  User? detailUser;


  void setUserList({required int start, required int count}) async{
    List<User> chunk = await UserHttp.getUserList(start: start, count: count);

    usersInTab.addAll(chunk);
    notifyListeners();

  }


  void setLoginUser({required User? user}){
    me = user;

    notifyListeners();
  }


  void setDetailUser({required int userIdx}) async{
    detailUser = null; //초기화
    detailUser = await UserHttp.findByIdx(userIdx: userIdx);

    notifyListeners();
  }


}