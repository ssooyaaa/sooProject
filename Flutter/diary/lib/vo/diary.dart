
class Diary {

  int diaryIdx = 0;
  int userIdx = 0;
  String title = '';
  String content = '';
  String imgUrl = '';
  String storageRefer = '';
  String savedDate = '';
  String songUrl = '';


  Diary({
    this.diaryIdx = 0,
    this.userIdx = 0,
    this.title = '',
    this.content = '',
    this.imgUrl = '',
    this.savedDate = '',
    this.storageRefer = '',
    this.songUrl = '',
  });

  factory Diary.fromJson(Map<String, dynamic> map){
    return Diary(
      diaryIdx: map['diary_idx']??0,
      userIdx: map['user_idx']??0,
      title: map['title']??'',
      content: map['content']??'',
      imgUrl: map['img_url']??'',
      savedDate: map['saved_date']??'',
      storageRefer: map['storage_ref']??'',
      songUrl: map['song_url']??'',
    );
  }

}