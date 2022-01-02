import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class GiftsListCard extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? borderColor;
  final String? image;
  final VoidCallback onTap;

  const GiftsListCard({Key? key,
    required this.title,
    required this.content,
    required this.borderColor,
    required this.image,
    required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:() => onTap(),
      child: SizedBox(
        height: size.height * 0.12,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor!,
                    width: size.width * 0.002,),
                  borderRadius: BorderRadius.circular(size.height * 0.02),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width * 0.22,
                      color: borderColor!,
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(size.height * 0.01),
                            child: FadeInImage.assetNetwork(
                                placeholder: AppAssets.horPlaceholder,
                                image: image!,
                                fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title!, style: TextStyle(color: AppColors.textDarkGray, fontSize: size.height * 0.02, fontWeight: FontWeight.w500), textAlign: TextAlign.start,).tr(),
                            SizedBox(height: size.height * 0.005,),
                            Text(content!, style: TextStyle(color: AppColors.textLightGray, fontSize: size.height * 0.014, fontWeight: FontWeight.w500)).tr(),
                          ],
                        ),
                      ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
