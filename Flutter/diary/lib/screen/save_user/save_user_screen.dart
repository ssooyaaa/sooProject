import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:diary/screen/save_user/save_user_id_screen.dart';
import 'package:diary/screen/save_user/save_user_phone_screen.dart';
import 'package:flutter/material.dart';


class SaveUserScreen extends StatefulWidget {
  const SaveUserScreen({super.key});

  @override
  State<SaveUserScreen> createState() => _SaveUserScreenState();
}

class _SaveUserScreenState extends State<SaveUserScreen> {

  bool allChecked = false;
  List<bool> checks = [false, false, false, false, false];

  void toggleAllCheckboxes(bool? value) {
    setState(() {
      allChecked = value ?? false; //value == null이라면 false할당 / 아니면 value 할당
      for (int i = 0; i < checks.length; i++) {
        checks[i] = allChecked;
      }
    });
  }

  void toggleSingleCheckbox(int index, bool? value) {
    setState(() {
      checks[index] = value ?? false;
      allChecked = [0,1,2].every((i) => checks[i]); // 0,1,2 항목이 체크되었는지 확인
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('JOIN', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // todo 뒤로가기 로직
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );

          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    '서비스 이용약관',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: allChecked,
                  onChanged: toggleAllCheckboxes,
                  title: Text(
                    '모두 동의 (선택 정보 포함)',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Divider(color: Colors.black45),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checks[0],
                  onChanged: (value) => toggleSingleCheckbox(0, value),
                  title: Expanded(
                    child: Text(
                      '만 14세 이상입니다. (필수)',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checks[1],
                  onChanged: (value) => toggleSingleCheckbox(1, value),
                  title: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '서비스 이용약관에 동의 (필수)',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            // "보기" 로직
                            print('보기버튼');
                          },
                          child: Text(
                            '보기',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checks[2],
                  onChanged: (value) => toggleSingleCheckbox(2, value),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '개인정보 수집 및 이용에 동의 (필수)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // "보기" 로직
                        },
                        child: Text(
                          '보기',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checks[3],
                  onChanged: (value) => toggleSingleCheckbox(3, value),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '리워드 프로그램 참여에 동의 (선택)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // "보기" 로직
                        },
                        child: Text(
                          '보기',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checks[4],
                  onChanged: (value) => toggleSingleCheckbox(4, value),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '광고 및 마케팅 수신에 동의 (선택)',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // "보기" 로직
                        },
                        child: Text(
                          '보기',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(height: 20,),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // todo 회원가입 버튼 로직
                // todo 이메일 또는 SMS 인증 먼저
                if(allChecked==true){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SaveUserPhoneScreen()),
                  );
                }else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('이용약관에 동의해주세요.')),
                  );
              },
              child: Text('회원가입', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                foregroundColor: allChecked ? Colors.black : Colors.black,
                backgroundColor: allChecked
                    ? AppColors.moreBasicColor
                    : AppColors.basicColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
