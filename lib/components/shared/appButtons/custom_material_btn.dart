import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget{
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color bgColor;
  final double btnSize;
  final double textSize;

  const CustomMaterialButton({Key? key,
    required this.title,
    required this.onTap,
    this.textColor = Colors.white,
    this.bgColor = Colors.cyan,
    this.btnSize = 0.0185,
    this.textSize = 0.025,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
        onPressed: () => onTap(),
        color: bgColor,
        elevation: 6.0,
        minWidth: size.width,
        splashColor: Colors.white.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height * 0.01),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            // vertical: size.height * 0.0185,
            vertical: size.height * btnSize,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.height * textSize,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ));
  }
}