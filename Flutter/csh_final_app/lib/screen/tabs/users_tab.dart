import 'package:csh_final_app/app_http/user_http.dart';
import 'package:csh_final_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../vo/user.dart';


class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {

  int _start = 0;

  void initState(){
    super.initState();
    Provider.of<UserModel>(context, listen: false).setUserList(start: _start, count: 50);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,

        child: SingleChildScrollView(
          child: Consumer<UserModel>(builder: (context, model, child){
            return Column(
              children: model.usersInTab.map((u)=>UserBox(user: u,)).toList(),
            );
          }),
        )

      ),
    );
  }
}


class UserBox extends StatelessWidget {

  User user;
  UserBox({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
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

    );
  }
}
