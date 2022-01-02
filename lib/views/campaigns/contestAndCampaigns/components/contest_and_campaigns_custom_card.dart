import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ContestAndCampaignsCustomDialog extends StatelessWidget {
  final String? circle;
  final String? icon;
  String? index;
  final String? title;
  final String? content;
  final VoidCallback onTap;

  ContestAndCampaignsCustomDialog({Key? key,
    required this.circle,
    required this.icon,
    required this.index,
    required this.title,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(index){
      case '1':
        index = 'one_tr';
        break;
      case '2':
        index = 'two_tr';
        break;
      case '3':
        index = 'three_tr';
        break;
    }
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:() => onTap(),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01,horizontal: size.width * 0.01,),
          child: Row(
            children: [
              SizedBox(
                  width: size.width * 0.2,
                  child: Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.16,
                          width: size.width,
                          child:  CircleAvatar(
                            radius: 15.0,
                            child: SvgPicture.asset(
                              circle!,
                              height: size.height * 0.10,
                              width: size.width * 0.10,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        FractionalTranslation(
                          translation: const Offset(0.0, -0.2),
                          child: Align(
                            child: Image.asset(icon!,
                              height: size.height * 0.35,
                              width: size.width * 0.35,),
                            // alignment: const FractionalOffset(0.5, 0.0),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.045,
                      width: size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.05,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: size.height * 0.14,
                                  width: size.width,
                                  child:  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.002,),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      child: SvgPicture.asset(AppAssets.circleYellow),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                FractionalTranslation(
                                  translation:  Offset(0.0, size.height * 0.0),
                                  child: Align(
                                    child: Text(index!, style: TextStyle(fontSize: size.height * AppConstants.btnVerPadding,),).tr(),
                                  ),
                                ),
                              ],
                            ),

                          ),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                child: Text(title!, style: TextStyle(fontSize: size.height * 0.025, color:  AppColors.appColor, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,)).tr(),
                                /*child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: ("campaign_tr").tr(),
                                              style: TextStyle(fontSize: size.height * 0.025, color:  Colors.grey.shade700, fontWeight: FontWeight.w500)
                                          ),
                                          TextSpan(
                                              text: (" - ").tr(),
                                              style: TextStyle(fontSize: size.height * 0.025, color:  Colors.grey.shade700, fontWeight: FontWeight.w500)
                                          ),
                                          TextSpan(
                                              text: (title!).tr(),
                                              style: TextStyle(fontSize: size.height * 0.025, color:  AppColors.appColor, fontWeight: FontWeight.w500)
                                          ),
                                        ]
                                    )
                                ),*/
                              )
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey,
                          width: size.width * 0.05,
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.00, horizontal: size.width * 0.02),
                              child: Text(
                                  content!,
                                  style: TextStyle(fontSize: size.height * 0.020, color: Colors.grey.shade500)).tr(),
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: size.width * 0.1,
                  child: Column(
                      children: [
                        SizedBox(
                            height: size.height * 0.04,
                            width: size.width,
                            child: Image.asset(
                              AppAssets.campaignsStart,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                            )
                        ),
                      ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
