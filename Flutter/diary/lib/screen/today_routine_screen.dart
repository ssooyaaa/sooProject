import 'package:flutter/material.dart';



class TodayRoutineScreen extends StatefulWidget {
  const TodayRoutineScreen({super.key});

  @override
  State<TodayRoutineScreen> createState() => _TodayRoutineScreenState();
}

class _TodayRoutineScreenState extends State<TodayRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('TODAY ROUTINES'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
