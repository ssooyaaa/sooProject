import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/diary_screen.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:flutter/material.dart';


class BottomWidget extends StatefulWidget {
  int bottomSelectedIdx;

  BottomWidget({super.key, required this.bottomSelectedIdx});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {


  List<Widget> pages = [
    MainScreen(),
    DiaryScreen(),
  ];

  void onItemTapped(int index){
    setState(() {
      widget.bottomSelectedIdx = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.bottomSelectedIdx,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.basicColor,
        currentIndex: widget.bottomSelectedIdx,
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
