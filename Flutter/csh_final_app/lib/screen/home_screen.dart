
import 'package:csh_final_app/model/user_model.dart';
import 'package:csh_final_app/screen/tabs/boards_tab.dart';
import 'package:csh_final_app/screen/tabs/mypage_tab.dart';
import 'package:csh_final_app/screen/tabs/users_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int selectedIdx = 0;

  List<Widget> tabs = [
    UsersTab(),
    BoardsTab(),
    MypageTab()
  ];

  List<String> appBarTitles = [
    '회원리스트',
    '게시판',
    '마이페이지'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(appBarTitles[selectedIdx]),
        elevation: 0,
      ),
      body: IndexedStack(
        index: selectedIdx,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '회원리스트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label:'마이페이지',
          ),
        ],
        currentIndex: selectedIdx,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            selectedIdx = index;
          });
        },
      ),
    );
  }
}


/*Consumer<UserModel>(builder: (context, userModel, child){
              return Text(userModel.me!.id, style: TextStyle(fontSize: 30),);
            }),

            ElevatedButton(
                onPressed: () async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setInt('login_user_idx', 0);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('로그아웃'),
            ),*/
