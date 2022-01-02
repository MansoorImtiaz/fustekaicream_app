import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ProductsLocal {
  const ProductsLocal({this.title, this.icon, this.quantity});
  final String? title;
  final String? icon;
  final String? quantity;
}

class ProductsBody extends StatefulWidget {
  final bool? isAppBar;
  const ProductsBody({Key? key, required this.isAppBar}) : super(key: key);

  @override
  _ProductsBodyState createState() => _ProductsBodyState(isAppBar: isAppBar);
}

class _ProductsBodyState extends State<ProductsBody> {

  final bool? isAppBar;
  _ProductsBodyState({required this.isAppBar});

  final AppFunctions _appFunctions = AppFunctions();
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  AppViewModels listAppViewModel = AppViewModels();
  final SharedPref _sharedPref =  SharedPref();
  String? lang = 'en';


  @override
  void initState() {
    getLang();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      if(event.appLang.contains(AppConstants.products)){
        setState(() {});
      }
    });
    super.initState();
  }

  getLang() async{
    lang = await _sharedPref.getLang();
    print('lang = '+lang!);
  }

  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 130) / 2;
    final double itemWidth = size.width / 2;
    AppConstants.currentScreen = AppConstants.products;
    return Scaffold(
      appBar: isAppBar == true
          ? AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        //for add/remove back arrow
        title: Center(
          child: const Text('products_tr').tr()),
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
              ? FutureBuilder(
            future: listAppViewModel.fetchAllProducts(),
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
                    if(listAppViewModel.products!.isNotEmpty) {
                      _appFunctions.loadingDismiss();
                      return Padding(
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
                          children: List.generate(listAppViewModel.products!.length, (index) {
                            return GridViewNewCard(
                              productName: listAppViewModel.products![index].list!.title!,
                              price: listAppViewModel.products![index].list!.price!,
                              productSize: listAppViewModel.products![index].list!.productSize!,
                              icon: listAppViewModel.products![index].list!.image!,
                              color: listAppViewModel.products![index].list!.colorCode!,
                              onTap: (){
                                Navigator.push(context, AppRoutes().productsDetailScreen(
                                  listAppViewModel.products![index].list!.transId!,
                                  listAppViewModel.products![index].list!.price!,
                                ));
                                print('trans_id == '+listAppViewModel.products![index].list!.transId!.toString());
                              },
                            );
                          }),
                        ),
                      );
                    }else{
                      _appFunctions.loadingDismiss();
                      return Center(child: const Text('no_record_found_tr').tr());
                    }
                  }
              }
            },
          )
              : Center(child: const Text('no_internet_tr').tr())
      ),
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
