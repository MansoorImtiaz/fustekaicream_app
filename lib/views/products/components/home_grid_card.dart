import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class HomeGridCard extends StatelessWidget {
  final String productName;
  final String icon;
  final String color;
  final VoidCallback onTap;

  const HomeGridCard({
    Key? key,
    required this.productName,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppFunctions _appFunctions = AppFunctions();
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: _appFunctions.getHexColor(color),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: _appFunctions.getHexColor(color), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.015),
              // padding: EdgeInsets.all(size.height * 0.0),
              child: Container(
                  height: size.height * 0.15,
                  width: size.width,
                  // color: Colors.lightGreen,
                  child: Center(
                    child: SimpleShadow(
                      child: Image.asset(icon, fit: BoxFit.fill,),
                      /*child: FadeInImage.assetNetwork(
                        placeholder: AppAssets.placeholder,
                        image: icon,
                        fit: BoxFit.fill,
                      ),*/
                      opacity: 0.8,         // Default: 0.5
                      color: Colors.black54,   // Default: Black
                      offset: const Offset(5, 5), // Default: Offset(2, 2)
                      sigma: 5,// Default: 2
                    ),
                  )
              ),
            ),
          ),
          Center(
            child: Text(
              productName,
              style: TextStyle(
                  fontSize: size.height * 0.020, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ),
        ],
      ),
    );
  }
}
