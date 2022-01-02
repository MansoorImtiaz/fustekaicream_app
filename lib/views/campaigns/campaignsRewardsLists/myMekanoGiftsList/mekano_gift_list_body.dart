import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/campaigns/campaignsRewardsLists/components/gifts_list_card.dart';

class MekanoGiftListBody extends StatefulWidget {
  const MekanoGiftListBody({Key? key}) : super(key: key);

  @override
  _MekanoGiftListBodyState createState() => _MekanoGiftListBodyState();
}

class _MekanoGiftListBodyState extends State<MekanoGiftListBody> {

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
          title: Center(child: const Text('my_mekano_gift_tr', textAlign: TextAlign.center).tr()),
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
                          image: AssetImage(AppAssets.myMekanoGiftListTop),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomElevationBtn(
                              title: tr('uploaded_images_tr'),
                              bgColor: AppColors.appColor,
                              textColor: Colors.white,
                              textSize: size.height * 0.020,
                              onTap: (){
                                Navigator.push(context, AppRoutes().mekanoUploadedImagesScreen,);
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.02,),
                          Expanded(
                            child: CustomElevationBtn(
                              title: tr('upload_image_tr'),
                              bgColor: AppColors.appColor,
                              textColor: Colors.white,
                              textSize: size.height * 0.020,
                              onTap: (){
                                Navigator.push(context, AppRoutes().mekanoUploadingScreen,);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: Center(
                        child: FutureBuilder(
                          future: listAppViewModel.fetchWinnerMekanos(context, userId!),
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
                                  if(listAppViewModel.winnerMekanos!.isNotEmpty) {
                                    print('inside= '+listAppViewModel.winnerMekanos!.toString());
                                    _appFunctions.loadingDismiss();
                                    return ListView.builder(
                                        itemCount: listAppViewModel.winnerMekanos!.length,
                                        shrinkWrap: true, // U
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                                            child: MekanoWinnerCard(
                                              winnerMekano: listAppViewModel.winnerMekanos![index].winnerMekanos!,
                                              onTap: () {  },
                                            ),
                                          );
                                        });
                                  }else{
                                    _appFunctions.loadingDismiss();
                                    return Center(child: const Text('no_mekano_gifts_tr').tr());
                                  }
                                }
                            }
                          },
                        ),
                      )
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
