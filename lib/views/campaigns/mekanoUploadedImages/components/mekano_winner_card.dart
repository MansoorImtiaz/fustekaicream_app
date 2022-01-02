import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class MekanoWinnerCard extends StatelessWidget {
  final WinnerMekano winnerMekano;
  final VoidCallback onTap;

  const MekanoWinnerCard({Key? key,
    required this.winnerMekano,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap:() => onTap(),
        child: Column(
          children: [
            Text(winnerMekano.winningDate!, style: TextStyle(color: AppColors.appColor, fontSize: size.height * 0.02, fontWeight: FontWeight.w500)).tr(),
            Stack(
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  width: size.width * 0.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.0, horizontal: size.height * 0.0),
                    child: Card(
                        elevation: 6.0,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: size.width * 0.02,),
                          borderRadius: BorderRadius.circular(size.height * 0.03),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: winnerMekano.image!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Image.asset(AppAssets.horPlaceholder,),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        /*child: FadeInImage.assetNetwork(
                          placeholder: AppAssets.horPlaceholder,
                          image: winnerMekano.image!,
                          fit: BoxFit.fill,)*/
                    ),
                  ),
                ),
                Visibility(
                  visible: winnerMekano.winningStatus!.contains('1')?true:false,
                  child: Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: GestureDetector(
                      onTap: (){},
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          AppAssets.campaignGalleryRibbon,
                          fit: BoxFit.fill,
                          height: size.height * 0.05,
                          width: size.width * 0.1,
                          // alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
