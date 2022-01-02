import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/campaigns/contestAndCampaigns/components/contest_and_campaigns_custom_card.dart';

final titles = ["List 1", "List 2", "List 3"];
final subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];

class ContestCampaignsModel {
  const ContestCampaignsModel({this.circle, this.icon, this.title, this.content});
  final String? circle;
  final String? icon;
  final String? title;
  final String? content;
}


class ContestAndCampaignBody extends StatefulWidget {
  final bool? isAppBar;
  const ContestAndCampaignBody({Key? key, required this.isAppBar}) : super(key: key);

  @override
  _ContestAndCampaignBodyState createState() => _ContestAndCampaignBodyState(isAppBar: isAppBar);
}

class _ContestAndCampaignBodyState extends State<ContestAndCampaignBody> {

  final bool? isAppBar;
  _ContestAndCampaignBodyState({required this.isAppBar});
  bool? isUserActive = false;
  final SharedPref _sharedPref =  SharedPref();

  @override
  void initState() {
    getUser();
    EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      if(event.appLang.contains(AppConstants.campaigns)){
        setState(() {});
      }
    });
    super.initState();
  }

  void getUser() async{
    isUserActive = await _sharedPref.getIsUserActive();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppConstants.currentScreen = AppConstants.campaigns;
    return Scaffold(
      appBar: isAppBar == true
          ? AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        //for add/remove back arrow
        title: Center(
            child: const Text('campaigns_tr').tr()),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: const [
          Text('00',
              style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
        ],
      )
          : null,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02,horizontal: size.width * 0.02,),
            child: ListView.builder(
                itemCount : titles.length,
                shrinkWrap: true, // Use  children total size
                itemBuilder : (context, index){
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
                    child: SizedBox(
                      height: size.height * 0.15,
                        child: ContestAndCampaignsCustomDialog(
                          title: AppConstants.contestCampaignsList[index].title,
                          content: AppConstants.contestCampaignsList[index].content,
                          index: (index + 1).toString(),
                          icon: AppConstants.contestCampaignsList[index].icon,
                          circle: AppConstants.contestCampaignsList[index].circle,
                          onTap: () async {
                            isUserActive = await _sharedPref.getIsUserActive();
                            switch(index){
                              case 0:
                                if(isUserActive == true){
                                  Navigator.push(context, AppRoutes().instantGiftListScreen,);
                                }else{
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return const LoginDialog();
                                  });
                                }
                                break;
                              case 1:
                                if(isUserActive == true){
                                  Navigator.push(context, AppRoutes().lotteryRewardListScreen,);
                                }else{
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return const LoginDialog();
                                  });
                                }
                                break;
                              case 2:
                                if(isUserActive == true){
                                  Navigator.push(context, AppRoutes().mekanoGiftListScreen,);
                                }else{
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return const LoginDialog();
                                  });
                                }
                                print('userIsActive== '+isUserActive.toString());
                                break;
                            }
                          },
                        )
                    ),
                  );
                }
            )
          ),
        ),
      ),
    );
  }
}
