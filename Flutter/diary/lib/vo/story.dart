

import 'package:diary/vo/diary_img.dart';

class Story{

  String title;
  String imgUrl;
  String content;
  int diaryIdx;
  List<DiaryImg> imgList;

  Story({
    required this.title,
    required this.imgUrl,
    required this.content,
    required this.diaryIdx,
    required this.imgList
  });


  factory Story.fromJson(Map<String, dynamic> map){
    return Story(
      title: map['title'],
      imgUrl: map['img_url']??'',
      content: map['content']??'',
      diaryIdx: map['diary_idx']??0,
      imgList: map['img_list']??[],
    );
  }

}