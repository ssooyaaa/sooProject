

import 'dart:convert';

import 'package:diary/config/app_config.dart';
import 'package:http/http.dart' as http;

import '../vo/user.dart';

class UserHttp{

  //todo 회원가입
  static Future<bool> save({required User user}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/user/saveUser';
    Uri uri = Uri.parse(requestUrl);

    var urlParam = uri.replace(queryParameters: {
      'id':user.id.toString(),
      'pw':user.pw.toString(),
      'nick':user.nick.toString(),
      'uid':user.uid.toString(),
      'phone_number':user.phoneNumber.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok'){
      return true;
    }else
      return false;

  }

  //todo 휴대폰 조회
  static Future<User?> findByPhoneNumber({required String phoneNumber}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByPhoneNumber';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'phone_number':phoneNumber.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else
      return null;

  }


  //todo 로그인(아이디, 비밀번호로 조회)
  static Future<User?> findByIdAndPw({required User user}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByIdAndPw';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'id':user.id.toString(),
      'pw':user.pw.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else
      return null;
  }


  //todo idx로 user가져오기
  static Future<User?> findByIdx({required int idx}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByIdx';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'user_idx':idx.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else
      return null;

  }



  //todo 아이디 중복조회
  static Future<User?> findById({required String userId}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findById';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'id':userId,
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else
      return null;
  }

  //todo 새로운 비밀번호로 변경
  static Future<bool> updateUser({required User user}) async{
    var requestUrl = '${AppConfig.apiAddress}/api/user/updateUser';
    Uri uri = Uri.parse(requestUrl);

    var urlParam = uri.replace(queryParameters: {
      'user_idx':user.userIdx.toString(),
      'pw':user.pw.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok'){
      return true;
    }else
      return false;

  }

  //todo 비밀번호 찾기(아이디, 번호 조회)
  static Future<User?> findByPhoneAndId({required User user}) async{

    var requestUrl = '${AppConfig.apiAddress}/api/user/findByPhoneAndId';

    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'phone_number':user.phoneNumber.toString(),
      'id':user.id.toString(),
    });

    var response = await http.get(urlParam);

    if(response.body.isNotEmpty){
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }else
      return null;
  }

}