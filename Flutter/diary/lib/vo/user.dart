

class User{

  int userIdx = 0;
  String userCode = '';
  String id = '';
  String pw = '';
  String nick = '';
  String createdDate = '';
  String uid = '';
  String phoneNumber = '';

  User({
    this.userIdx = 0,
    this.userCode = '',
    this.id = '',
    this.pw = '',
    this.nick = '',
    this.createdDate = '',
    this.uid = '',
    this.phoneNumber = '',
  });

  factory User.fromJson(Map<String, dynamic> map){
    return User(
      userIdx: map['user_idx']??0,
      userCode: map['user_code']??'',
      id: map['id']??'',
      pw: map['pw']??'',
      nick: map['nick']??'',
      createdDate: map['created_date']??'',
      uid: map['uid']??'',
      phoneNumber: map['phone_number']??'',
    );
  }
}
