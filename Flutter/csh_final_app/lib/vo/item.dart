

class Item{
  int itemIdx=0;
  int userIdx=0;
  String title='';
  String content='';
  String imgUrl='';
  String createdDate='';


  Item({
    this.itemIdx=0,
    this.userIdx=0,
    this.title='',
    this.content='',
    this.imgUrl='',
    this.createdDate=''
  });

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      itemIdx: json['item_idx'],
      userIdx: json['user_idx'],
      title: json['title'],
      content: json['content'],
      imgUrl: json['img_url'],
      createdDate: json['created_date']
    );
  }

}