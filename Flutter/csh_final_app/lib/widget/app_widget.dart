import 'package:csh_final_app/config/app_color.dart';
import 'package:flutter/material.dart';


//todo long 버튼
class LongButton extends StatelessWidget {

  final double width;
  final double height;
  final Function onTap;
  final double borderRadius;
  final Widget child;
  final Color backgroundColor;

  LongButton({Key? key,
    this.height=50,
    required this.onTap,
    required this.width,
    this.borderRadius=10,
    required this.child,
    required this.backgroundColor
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: (){
          onTap();
        },
        child: SizedBox(
            width: width,
            height: height,
            child: child
        ),
      ),
    );
  }
}



//todo 입력 input
class AppInput extends StatelessWidget {

  double width;
  TextEditingController textEditingController;
  String hintText;
  bool isWarn;
  bool isPassword;

  AppInput({
    required this.width,
    required this.textEditingController,
    this.hintText='',
    this.isWarn=false,
    this.isPassword=false,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,

      ),
      width: width,

      child: TextField(
        obscureText: isPassword,
        controller: textEditingController,
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 8),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isWarn ? const Color(0xffEC0F0F) : Colors.grey
                      .shade300)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor, width: 1.5)
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}


