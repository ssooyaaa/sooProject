import 'package:flutter/material.dart';

import '../config/app_colors.dart';


class FloatingButton extends StatefulWidget {

  Function(BuildContext) onScreenSelected;
  String buttonText;

  FloatingButton({
    required this.onScreenSelected,
    required this.buttonText,
  });

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.moreBasicColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: (){
        widget.onScreenSelected(context);
      },
      label: Text(widget.buttonText,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
