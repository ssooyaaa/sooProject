import 'package:diary/model/user_model.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LocalNotification.dart';
import '../config/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  List<Widget>? actions;

  CustomAppBar({
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          ...?actions, //페이지별 actions 리스트
          /*IconButton(
              onPressed: (){
                LocalNotification.showSimpleNotification(
                    title: '테스팅 11', body: ' 제발요', payload: "일반 푸시 알람 데이터");

              },
              icon: Icon(Icons.access_alarm)
          ),*/
          IconButton(
              //todo 로그아웃 설정
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('로그아웃 하시겠습니까?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop(false); //삭제 취소
                            },
                            child: Text('취소',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () async{
                              Navigator.of(context).pop(true); //삭제

                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('login_user_idx', 0);

                              Provider.of<UserModel>(context, listen: false).logout();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('로그아웃되었습니다.')),
                              );

                              //todo 로그인창으로 이동
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (route) => false, // 이전 모든 라우트를 제거
                              );

                            },
                            child: Text('로그아웃',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      );
                    }
                );
              },
              icon: Icon(Icons.logout,),
          )
        ],
      ),
/*
      drawer: Drawer(

        backgroundColor: AppColors.basicColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/User.jpg'),
                backgroundColor: AppColors.moreBasicColor,
              ),

              accountName: Text(
                'Soo',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              accountEmail: Text(
                'tngus8474@gmail.com',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              decoration: BoxDecoration(
                color: AppColors.moreBasicColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                border: null,

              ),
            ),

            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[800],
              ),
              title: Text('Home',
                style: TextStyle(fontSize: 17),
              ),
              onTap: (){
                print('home클릭');
              },
              trailing: Icon(Icons.add),
            )

          ],

        ),
      ),*/

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
