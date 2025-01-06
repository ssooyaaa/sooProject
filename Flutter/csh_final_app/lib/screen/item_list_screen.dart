import 'package:csh_final_app/screen/register_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {


  final List<Map<String, dynamic>> items = [
    {
      'title': '보스 사운드링크 미니2 그레이 중고',
      'location': '역삼동',
      'time': '4분 전',
      'price': '130,000원',
      'image': 'https://via.placeholder.com/100',
      'likes': 1,
    },
    {
      'title': '아이폰 xs 케이스 팔아요',
      'location': '서초2동',
      'time': '5분 전',
      'price': '5,000원',
      'image': 'https://via.placeholder.com/100',
      'likes': 0,
    },
    {
      'title': '아이폰 xs 투명 케이스 팔아요',
      'location': '서초2동',
      'time': '5분 전',
      'price': '3,000원',
      'image': 'https://via.placeholder.com/100',
      'likes': 2,
    },
    {
      'title': '베이비그루트 블루투스 스피커',
      'location': '논현1동',
      'time': '11분 전',
      'price': '21,000원',
      'image': 'https://via.placeholder.com/100',
      'likes': 20,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  item['image'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${item['location']} · ${item['time']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['price'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: item['likes'] > 0 ? Colors.red : Colors.grey),
                              SizedBox(width: 4),
                              Text('${item['likes']}'),
                            ],
                          ),

                        ],
                      ),


                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //작성 스크린 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterItemScreen()),
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }
}

