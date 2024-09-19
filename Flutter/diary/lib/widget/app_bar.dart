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

        actions: actions,
      ),

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
      ),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
