

class User{
  int userIdx = 0;
  String userCode = '';
  String id = '';
  String pw = '';
  String nick = '';
  String address = '';
  String createdDate = '';


  User({
    this.userIdx = 0,
    this.userCode = '',
    this.id = '',
    this.pw = '',
    this.nick = '',
    this.address = '',
    this.createdDate = '',
  });


  factory User.fromJson(Map<String, dynamic> map){
    return User(
      userIdx: map['user_idx'],
      userCode: map['user_code'],
      id: map['id'],
      pw: map['pw'],
      nick: map['nick'],
      address: map['address'],
      createdDate: map['created_date'],
    );
  }
}