import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/campaigns/campaignsRewardsLists/components/gifts_list_card.dart';

class LotteryRewardListBody extends StatefulWidget {
  const LotteryRewardListBody({Key? key}) : super(key: key);

  @override
  _LotteryRewardListBodyState createState() => _LotteryRewardListBodyState();
}

class _LotteryRewardListBodyState extends State<LotteryRewardListBody> {

  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? userId = '';
  final SharedPref _sharedPref =  SharedPref();
  AppViewModels listAppViewModel = AppViewModels();
  final AppFunctions _appFunctions = AppFunctions();

  @override
  void initState() {
    super.initState();
    getPrefData();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  getPrefData() async{
    userId = await _sharedPref.getUserId();
    print('userId=='+userId.toString());
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true, //for add/remove back arrow
          title: Center(child: const Text('my_lottery_reward_tr', textAlign: TextAlign.center).tr()),
          backgroundColor: AppColors.appColor,
          foregroundColor: AppColors.white,
          actions: const [
            Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
          ],
        ),
        body: SafeArea(
            child: _connectionStatus
                ? Center(
              child: Container(
                height: size.height,
                width: size.width,
                color: AppColors.screenBG,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.28,
                      width: size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.myLotteryRewardListTop),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: FutureBuilder(
                        future: listAppViewModel.fetchWinnerLotteries(context, userId!),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {

                            case ConnectionState.waiting:
                              _appFunctions.startLoading();
                              return const Center();
                            default:
                              if (snapshot.hasError) {
                                _appFunctions.loadingDismiss();
                                return Text('Error: ${snapshot.error}');
                              }
                              else {
                                if(listAppViewModel.winnerLotteries != null && listAppViewModel.winnerLotteries!.isNotEmpty) {
                                  print('inside= '+listAppViewModel.winnerLotteries!.toString());
                                  _appFunctions.loadingDismiss();
                                  return ListView.builder(
                                      itemCount: listAppViewModel.winnerLotteries!.length,
                                      shrinkWrap: true, // U
                                      itemBuilder: (context, index){
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.045),
                                          child: GiftsListCard(
                                            title: listAppViewModel.winnerLotteries![index].winnerLotteries!.randomNumber!,
                                            content: listAppViewModel.winnerLotteries![index].winnerLotteries!.winningDate!,
                                            image: listAppViewModel.winnerLotteries![index].winnerLotteries!.qrCode!,
                                            borderColor: AppColors.lotteryRewardListBlue,
                                            onTap: () {  },
                                          ),
                                        );
                                      });
                                }else{
                                  _appFunctions.loadingDismiss();
                                  return Center(child: const Text('no_instant_Lottery_gifts_tr').tr());
                                }
                              }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Center(child: const Text('no_internet_tr').tr())
        )
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = false);
        break;
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }
}
