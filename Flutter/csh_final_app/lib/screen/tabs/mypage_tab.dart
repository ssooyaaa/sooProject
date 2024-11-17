import 'package:flutter/material.dart';

class MypageTab extends StatefulWidget {
  const MypageTab({super.key});

  @override
  State<MypageTab> createState() => _MypageTabState();
}

class _MypageTabState extends State<MypageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
