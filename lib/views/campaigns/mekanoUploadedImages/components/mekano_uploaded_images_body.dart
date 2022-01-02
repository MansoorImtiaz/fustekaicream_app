import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class MekanoUploadedImagesBody extends StatefulWidget {
  const MekanoUploadedImagesBody({Key? key}) : super(key: key);

  @override
  _MekanoUploadedImagesBodyState createState() => _MekanoUploadedImagesBodyState();
}

class _MekanoUploadedImagesBodyState extends State<MekanoUploadedImagesBody> {
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? userId = '';
  final SharedPref _sharedPref =  SharedPref();
  AppViewModels listAppViewModel = AppViewModels();
  final AppFunctions _appFunctions = AppFunctions();

  @override
  void initState() {
    getPrefData();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
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
        title: Center(child: const Text('uploaded_images_tr', textAlign: TextAlign.center).tr()),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.white,
        actions: const [
          Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
        ],
      ),
      body: SafeArea(
            child: _connectionStatus
                ? Center(
                    child: FutureBuilder(
                future: listAppViewModel.fetchAllMekanosImages(context, userId!),
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
                        if(listAppViewModel.allMekanosImages!.isNotEmpty) {
                          print('inside= '+listAppViewModel.allMekanosImages!.toString());
                          _appFunctions.loadingDismiss();
                          return ListView.builder(
                              itemCount: listAppViewModel.allMekanosImages!.length,
                              shrinkWrap: true, // U
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                                  child: MekanoWinnerCard(
                                    winnerMekano: listAppViewModel.allMekanosImages![index].allMekanosImages!,
                                    onTap: () {  },
                                  ),
                                );
                              });
                        }else{
                          _appFunctions.loadingDismiss();
                          return Center(child: const Text('no_record_found_tr').tr());
                        }
                      }
                  }
                },
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
