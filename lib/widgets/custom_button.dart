import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';



class CustomButton extends HookWidget {
  final String buttonText;
  final void Function() onTab;
  final bool? size;

  final double? fontSize;

  CustomButton(
      {required this.onTab,
      required this.buttonText,
      this.fontSize,
      this.size = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.7),
        
            padding:   EdgeInsets.symmetric(horizontal: 40.w, vertical: 1.5.h)),
      onPressed: onTab,
      child: Text(
      
        buttonText,
        maxLines: 1,
           
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13.sp),
      ),
    );
  }
}
