

class DiaryImg{

  int diaryImgIdx = 0;
  int diaryIdx = 0;
  String imgUrl = '';
  String createdDate = '';
  String storageRefer = '';

  DiaryImg({
    this.diaryImgIdx = 0,
    this.diaryIdx = 0,
    this.imgUrl = '',
    this.createdDate = '',
    this.storageRefer = '',
  });

  factory DiaryImg.fromJson(Map<String, dynamic> map){
    return DiaryImg(
      diaryImgIdx: map['diary_img_idx']??0,
      diaryIdx: map['diary_idx']??0,
      imgUrl: map['img_url']??'',
      createdDate: map['created_date']??'',
      storageRefer: map['storage_ref']??''
    );
  }

}