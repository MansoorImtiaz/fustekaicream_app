import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class CategoryBody extends StatefulWidget {
  final bool? isAppBar;
  const CategoryBody({Key? key, required this.isAppBar}) : super(key: key);

  @override
  _CategoryBodyState createState() => _CategoryBodyState(isAppBar: isAppBar);
}

class _CategoryBodyState extends State<CategoryBody> {

  final bool? isAppBar;
  _CategoryBodyState({required this.isAppBar});

  final AppFunctions _appFunctions = AppFunctions();
  AppViewModels listAppViewModel = AppViewModels();
  final SharedPref _sharedPref =  SharedPref();
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? lang = '';

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      if(event.appLang.contains(AppConstants.categories)){
        setState(() {});
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.currentScreen = AppConstants.categories;
    Size size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 180) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: isAppBar == true
            ? AppBar(
                centerTitle: true,
                automaticallyImplyLeading: true,
                //for add/remove back arrow
                title: Center(
                    child: const Text('categories_tr').tr()),
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                actions: const [
                  Text('00',
                      style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
                ],
            )
            : null,
         body: SafeArea(
            child: _connectionStatus
                ? Center(
                    child: FutureBuilder(
                    future: listAppViewModel.fetchCategories(),
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
                        listAppViewModel.categories ?? [];
                        if(listAppViewModel.categories!.isNotEmpty){
                          _appFunctions.loadingDismiss();
                          return Container(
                            height: size.height,
                            width: size.width,
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: true,
                                  child: Container(
                                    height: size.height * 0.25,
                                    width: size.width,
                                    color: Colors.grey.shade200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        AppAssets.slide1,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.06),
                                      child: GridView.count(
                                        primary: false,
                                        // childAspectRatio: 1.4/2,//for 2 lines name 1.6/2
                                        childAspectRatio: (itemWidth / itemHeight),
                                        crossAxisSpacing: size.width * 0.04,
                                        mainAxisSpacing: 0,
                                        crossAxisCount: 2,
                                        controller: ScrollController(keepScrollOffset: false),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: List.generate(listAppViewModel.categories!.length, (index) {
                                          return GridViewNewCard(
                                            productName: listAppViewModel.categories![index].categories!.title!,
                                            price: '',
                                            productSize: '',
                                            icon: listAppViewModel.categories![index].categories!.catImage!,
                                            color: listAppViewModel.categories![index].categories!.colorCode!,
                                            isCategory: true,
                                            onTap: (){
                                              Navigator.push(context, AppRoutes().subCategoriesScreen(
                                                listAppViewModel.categories![index].categories!.transId!,
                                                listAppViewModel.categories![index].categories!.title!,
                                              ),);
                                              print('trans_id == '+listAppViewModel.products![index].list!.transId!.toString());
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                    /*child: GridView.count(
                                        primary: false,
                                        childAspectRatio: 1.8/2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        crossAxisCount: 2,
                                        children: List.generate(listAppViewModel.categories!.length, (index) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: SizedBox(
                                                  height: size.height * 0.15,
                                                  width: size.width * 0.40,
                                                  child: GridViewCustomCard(
                                                    icon: listAppViewModel.categories![index].categories!.catImage!,
                                                    circle: _appFunctions.getCardCircle(),
                                                    onTap: (){
                                                      Navigator.push(context, AppRoutes().subCategoriesScreen(
                                                        listAppViewModel.categories![index].categories!.transId!,
                                                        listAppViewModel.categories![index].categories!.title!,
                                                      ),);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.34,
                                                child: Text(
                                                  listAppViewModel.categories![index].categories!.title!,
                                                  style: TextStyle(
                                                      fontSize: size.height * 0.020, fontWeight: FontWeight.w500), textAlign: TextAlign.start, overflow: TextOverflow.clip,
                                                ).tr(),
                                              ),
                                            ],
                                          );
                                        }),

                                    ),*/
                                  ),
                                ),
                              ],
                            ),
                          );
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
