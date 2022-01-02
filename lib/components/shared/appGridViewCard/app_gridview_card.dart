import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class GridViewCustomCard extends StatelessWidget {
  final String icon;
  final String? circle;
  final VoidCallback onTap;
  final bool isLocalImg;

  const GridViewCustomCard({
    Key? key,
    required this.icon,
    required this.circle,
    required this.onTap,
    this.isLocalImg = false,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin:  EdgeInsets.fromLTRB(0.0, size.height * 0.03, 0.0, 0.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: size.height * 0.15,
                width: size.width,
                child:  Padding(
                  // padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 16.0),
                  padding: const EdgeInsets.all(0.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    child: SvgPicture.asset(circle!),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            Padding(
              // padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(0.0),
              child: FractionalTranslation(
                translation: const Offset(-0.1, -0.3),
                child: Align(
                  child: isLocalImg
                      ? Image.asset(icon,
                          /*height: size.height * 0.35,
                          width: size.width * 0.35,*/)
                      : Image.network(icon,
                          height: size.height * 0.35,
                          width: size.width * 0.35,),
                  alignment: const FractionalOffset(0.5, 0.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewNewCard extends StatelessWidget {
  final String productName;
  final String price;
  final String productSize;
  final String icon;
  final String color;
  final bool isCategory;
  final VoidCallback onTap;

  const GridViewNewCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.productSize,
    required this.icon,
    required this.color,
    this.isCategory = false,
    required this.onTap,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppFunctions _appFunctions = AppFunctions();
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: isCategory == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
              child: Container(
                height: size.height * 0.15,
                width: size.width,
                // color: Colors.lightGreen,
                child: Center(
                  child: SimpleShadow(
                    child: FadeInImage.assetNetwork(
                        placeholder: AppAssets.placeholder1,
                        image: icon,
                        fit: BoxFit.fill,
                    ),
                    opacity: 0.8,         // Default: 0.5
                    color: Colors.black54,   // Default: Black
                    offset: const Offset(5, 5), // Default: Offset(2, 2)
                    sigma: 5,// Default: 2
                  ),
                )
              ),
            ),
          ),
          Visibility(
            visible: isCategory == true ? false:true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price+' IQD',
                    style: TextStyle(
                      fontSize: size.height * 0.016,fontWeight: FontWeight.w500, color: AppColors.proQuantityPrice,
                    ), textAlign: TextAlign.start,
                  ).tr(),
                  Text(
                    productSize+' ml',
                    style: TextStyle(
                      fontSize: size.height * 0.014, color: AppColors.proQuantityPrice, fontWeight: FontWeight.w300,), textAlign: TextAlign.start,
                  ).tr(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Text(
              productName,
              style: TextStyle(
                  fontSize: size.height * 0.020, fontWeight: FontWeight.w500),
              maxLines: isCategory == true ? 1: 2,
              textAlign: isCategory == true ? TextAlign.center : TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ),
        ],
      ),
    );
  }
}
