import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/diary_screen.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:flutter/material.dart';


class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {

  int bottomSelectedIdx = 0;

  List<Widget> pages = [
    MainScreen(),
    DiaryScreen(),
  ];

  void onItemTapped(int index){
    setState(() {
      bottomSelectedIdx = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomSelectedIdx,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.basicColor,
        currentIndex: bottomSelectedIdx,
        onTap: onItemTapped,
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "루틴",
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories_outlined),
              label: "일기"
          )
        ],

        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
        ),

        unselectedItemColor: Colors.grey,

      ),
    );
  }
}
