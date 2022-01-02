import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class CustomElevationBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color bgColor;
  final bool btnBorder;
  final double textSize;
  final double horPadding;
  final double verPadding;

  const CustomElevationBtn({Key? key,
    required this.title,
    required this.onTap,
    this.textColor = Colors.white,
    this.bgColor = Colors.cyan,
    this.btnBorder = false,
    this.textSize = 0.025,
    this.horPadding = 0.00,
    this.verPadding = 0.00,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: btnBorder ? const BorderSide(color: AppColors.appColor): BorderSide(color: bgColor),
          ),
          primary: bgColor,
          padding: EdgeInsets.symmetric(horizontal: horPadding, vertical: verPadding),
        ),
        onPressed: () => onTap(),
        child: Text(title, style: TextStyle(color: textColor, fontSize: textSize,))
    );
  }
}
