

import '../config/app_config.dart';
import '../vo/item.dart';
import 'package:http/http.dart' as http;

class ItemHttp{

  //todo 아이템 등록
  static Future<bool> save({required Item item}) async {
    var requestUrl = '${AppConfig.apiAddress}/api/item/create';
    Uri uri = Uri.parse(requestUrl);
    var urlParam = uri.replace(queryParameters: {
      'user_idx': item.userIdx.toString(),
      'title': item.title.toString(),
      'content': item.content.toString(),
      'img_url': item.imgUrl.toString(),
    });

    var response = await http.post(urlParam);

    if(response.body=='ok' && response.statusCode==200){
      return true;
    }else{
      return false;
    }


  }

}