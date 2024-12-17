import 'package:csh_final_app/app_http/user_http.dart';
import 'package:csh_final_app/model/user_model.dart';
import 'package:csh_final_app/screen/detail_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../vo/user.dart';


class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {

  int start = 0;
  int count = 60;


  final ScrollController _scrollController = ScrollController();
  bool _hasTriggered = false; // 함수가 한 번 호출되었는지 여부를 저장

  void initState(){
    super.initState();
    Provider.of<UserModel>(context, listen: false).setUserList(start: start, count: count);
    _scrollController.addListener(_onScroll);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,

        child: SingleChildScrollView(
          controller: _scrollController,
          child: Consumer<UserModel>(builder: (context, model, child){
            return Column(
              children: model.usersInTab.map((u)=>UserBox(user: u,)).toList(),
            );
          }),
        )

      ),
    );


  }

  void _onScroll() {
    // 현재 스크롤 위치와 최대 스크롤 높이를 계산
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScrollPosition = _scrollController.position.pixels;

    // 70% 위치를 계산
    final triggerPosition = maxScrollExtent * 0.7;

    // 조건에 따라 특정 함수 호출
    if (!_hasTriggered && currentScrollPosition >= triggerPosition) {
      _hasTriggered = true; // 중복 호출 방지
      _triggerFunction();
    }
  }

  void _triggerFunction() {
    print("70% 위치에 도달했습니다!");

    start = start + count;

    Provider.of<UserModel>(context, listen: false).setUserList(start: start, count: count);

  }
}


class UserBox extends StatelessWidget {

  User user;
  UserBox({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailUserScreen()),
        );
      },

      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 4,),
            Text('${user.address}'),
            SizedBox(height: 4,),
            Text('${user.createdDate}'),
            SizedBox(height: 16,),
          ],
        ),

      ),
    );
  }
}
