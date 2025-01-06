import 'dart:convert';

import 'package:csh_final_app/config/app_config.dart';
import 'package:http/http.dart' as http;

import '../vo/user.dart';

class UserHttp{


  //todo 회원리스트
  static Future<List<User>> getUserList({required int start, required int count}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/getUserList';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'start':start.toString(),
      'count':count.toString(),
    });

    var response = await http.get(urlParam);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<User> users = [];
    for(var one in data){
      User u = User.fromJson(one);
      users.add(u);
    }

    return users;

  }


  //todo idx로 회원조회
  static Future<User?> findByIdx({required int userIdx}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByIdx';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'idx':userIdx.toString(),
    });

    var response = await http.get(urlParam);


    if(response.body.isNotEmpty) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
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