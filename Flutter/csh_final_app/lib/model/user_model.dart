

import 'package:csh_final_app/vo/user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{

  User? me;

  void setLoginUser({required User? user}){
    me = user;
    notifyListeners();
  }


}