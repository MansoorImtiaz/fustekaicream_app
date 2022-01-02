import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class HomeCustomCard extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const HomeCustomCard({Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, size.height * 0.015, 0.0, 0.0),
      child: GestureDetector(
        onTap:() => onTap(),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 100.0,
              ),
            ),
            FractionalTranslation(
              translation: const Offset(0.0, -0.3),
              child: Align(
                child: Image.asset(icon),
                alignment: const FractionalOffset(0.5, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}