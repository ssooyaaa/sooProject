import 'package:flutter/material.dart';

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
                            onPressed: (){
                              Navigator.of(context).pop(true); //삭제

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('로그아웃되었습니다.')),
                              );

                              //todo 로그인창으로 이동
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MainScreen()),
                              );*/
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
