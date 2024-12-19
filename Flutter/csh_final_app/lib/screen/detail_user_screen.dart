import 'package:flutter/material.dart';



class DetailUserScreen extends StatefulWidget {

  const DetailUserScreen({super.key});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('user.id'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            BoardBox(),
            BoardBox(),
          ],
        ),
      ),
    );
  }
}

class BoardBox extends StatefulWidget {
  const BoardBox({super.key});

  @override
  State<BoardBox> createState() => _BoardBoxState();
}

class _BoardBoxState extends State<BoardBox> {

  bool _showContent = false;
  bool _alarm = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'asset/images/applelogo.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('데이터 내용 타이틀',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: (){
                              setState(() {
                                _showContent = !_showContent;
                              });
                            },
                            icon: Icon(_showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,)
                        ),
                      ],
                    ),


                    if(_showContent)
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          '데이터 내용들데이터 내용들데이터 내용들데이터 내용들데이터 내용들데이터 내용들데이터 내용들데이터 내용들데이터 내용들',
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                          maxLines: null,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10,),
          if(_alarm)
            Padding(
              padding: EdgeInsets.all(10.0),

              child: Row(
                children: [
                  Text('신고사유',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(width: 28,),
                  Column(
                    children: [
                      Text('뭐때문에 신고합니다.'),
                      Text('뭐때문에 신고합니다.'),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
