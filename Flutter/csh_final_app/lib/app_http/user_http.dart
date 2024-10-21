import 'dart:convert';

import 'package:csh_final_app/config/app_config.dart';
import 'package:http/http.dart' as http;

import '../vo/user.dart';

class UserHttp{


  //todo idx로 회원조회
  static Future<User?> findByIdx({required int userIdx}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByIdx';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'idx':userIdx.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty) {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else {
      return null;
    }

  }


  //todo 아이디, 비번으로 조회
  static Future<User?> findByIdAndPw({required User user}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByIdAndPw';
    print(requestUrl);
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'id':user.id.toString(),
      'pw':user.pw.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty) {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else {
      return null;
    }
  }


  //todo 가입
  static Future<bool> save({required User user}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/user/create';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'id':user.id.toString(),
      'pw':user.pw.toString(),
      'nick':user.nick.toString(),
      'address':user.address.toString(),
    });

    var response = await http.post(urlParam);

    print(response.body);

    if(response.body=='ok'){
      return true;
    }else{
      return false;
    }
  }

}