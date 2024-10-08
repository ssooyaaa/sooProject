import 'package:csh_final_app/config/app_config.dart';
import 'package:http/http.dart' as http;

import '../vo/user.dart';

class UserHttp{

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