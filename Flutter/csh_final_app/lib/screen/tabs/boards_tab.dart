import 'package:flutter/material.dart';

class BoardsTab extends StatefulWidget {
  const BoardsTab({super.key});

  @override
  State<BoardsTab> createState() => _BoardsTabState();
}

class _BoardsTabState extends State<BoardsTab> {
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
