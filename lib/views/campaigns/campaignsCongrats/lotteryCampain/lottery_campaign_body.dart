import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LotteryCampaignBody extends StatefulWidget {
  const LotteryCampaignBody({Key? key}) : super(key: key);

  @override
  _LotteryCampaignBodyState createState() => _LotteryCampaignBodyState();
}

class _LotteryCampaignBodyState extends State<LotteryCampaignBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          //for add/remove back arrow
          title: Center(
              child: const Text('lottery_campaign_tr', textAlign: TextAlign.center).tr()),
          backgroundColor: AppColors.appColor,
          foregroundColor: AppColors.white,
          actions: const [
            Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
          ],
        ),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.02,),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.5,
                        width: size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAssets.lotteryCampaignGift),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04,),
                      Text('congrates_tr', style: TextStyle(
                          fontSize: size.height * 0.04,
                          color: AppColors.appColor,
                          fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,).tr(),
                      SizedBox(height: size.height * 0.015,),
                      Text('you_winner_tr', style: TextStyle(
                        fontSize: size.height * 0.03,
                        color: AppColors.textLightGray,),
                        textAlign: TextAlign.center,).tr(),
                      SizedBox(height: size.height * 0.015,),
                      Text('lottery_campaign_tr', style: TextStyle(
                        fontSize: size.height * 0.034,
                        color: AppColors.textDarkGray,),
                        textAlign: TextAlign.center,).tr(),
                      SizedBox(height: size.height * 0.02,),
                      SizedBox(
                        width: size.width * 0.6,
                        child: CustomElevationBtn(
                          title: tr('view_gift_tr'),
                          bgColor: AppColors.appColor,
                          textColor: Colors.white,
                          textSize: size.height * 0.025,
                          verPadding: size.height * 0.02,
                          onTap: () {

                          },
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }
}
