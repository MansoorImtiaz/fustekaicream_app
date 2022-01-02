import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class SubCategoriesLocal {
  const SubCategoriesLocal({this.id, this.title});
  final String? id;
  final String? title;
}

class SubCategoriesBody extends StatefulWidget {
  final String catId;
  final String title;
  const SubCategoriesBody({Key? key, required this.catId, required this.title}) : super(key: key);

  @override
  _SubCategoriesBodyState createState() => _SubCategoriesBodyState(catId: catId, title: title);
}

class _SubCategoriesBodyState extends State<SubCategoriesBody> {

  final String catId;
  final String title;
  _SubCategoriesBodyState({required this.catId, required this.title});

  int selectedCat = 0;
  int topSelectedCat = 0;
  int productCount = 1;
  bool isSubCategories = true;
  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  Connectivity internet = Connectivity();
  bool isOk = false;
  String appBarTitle = 'Stick';
  int? _langValue =  0;

  //============================
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<SubCategories?>? subCategoriesList = [];
  List<AllProducts?>? productsList = [];
  List<SubCategoriesLocal?>? categoriesLocalList = [];
  String? lang = 'en';

  callSubCategoryApi(String catid) async{
    _appFunctions.startLoading();
    appBarTitle = title;
    final service = ApiServices();
    subCategoriesList = await service.fetchSubCategoriesAPI(catid);
    if (subCategoriesList!.isNotEmpty) {
      selectedCat = 0;
      isSubCategories = true;
      print('okkk sub Category '+subCategoriesList![0]!.title!);
      productsList = await service.fetchSubCategoryProducts(subCategoriesList![0]!.transId);
      setState(() {
      });
    }else {
      isSubCategories = false;
      print('okkk NO SUB CAT');
      productsList = await service.fetchSubCategoryProducts(catid);
      setState(() {});
    }
    if(productsList!.isEmpty){
      productCount = 0;
    }else{
      productCount = 1;
    }
    if(categoriesLocalList!.isEmpty){
      categoriesLocalList!.add(SubCategoriesLocal(id: catId, title: title));
    }
    _appFunctions.loadingDismiss();
  }


  getLang() async{
    lang = await _sharedPref.getLang();
    print('lang = '+lang!);
  }

  @override
  void initState() {
    super.initState();
    callSubCategoryApi(catId);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
   /* EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      if(event.appLang.contains(AppConstants.subCategories)){
        callSubCategoryApi(catId);
      }
    });*/


  }

  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  //============================

  void deleteItems(int index) {
    var i = categoriesLocalList!.length-1;
    while (i > index) {
      categoriesLocalList!.removeAt(i);
      i--;
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.currentScreen = AppConstants.subCategories;
    Size size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 130) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(child: const Text('products_tr', textAlign: TextAlign.center).tr()),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
            child: _connectionStatus
                ? Center(child: Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.grey.shade200,
                      child: Column(
                        children: [
                          Visibility(
                            child: Container(
                              height: size.height * 0.075,
                              width: size.width,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: EdgeInsets.all(size.width * 0.035),
                                child: ListView.builder(
                                  itemCount: categoriesLocalList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                      GestureDetector(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                              padding: EdgeInsets.symmetric(vertical: size.height * 0.002, horizontal: size.width * 0.02),
                                              decoration: topSelectedCat == index
                                                  ? const BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),)
                                                  : BoxDecoration(
                                                color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                border: Border.all(width: size.width * 0.003, color: Colors.black54),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                    categoriesLocalList![index]!.title!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: size.height * 0.014,
                                                        fontWeight: FontWeight.w700,
                                                        color: topSelectedCat == index
                                                            ? Colors.white
                                                            : Colors.black54),
                                                  )),
                                            ),
                                            Icon(Icons.arrow_forward_ios, size: size.height * 0.016,)
                                          ],
                                        ),
                                        onTap: () {
                                          callSubCategoryApi(categoriesLocalList![index]!.id!);
                                          deleteItems(index);
                                          topSelectedCat = index;
                                          setState(() {

                                          });
                                          /*callSubCategoryApi(subCategoriesList![index]!.id!);
                                          setState(() {
                                            topSelectedCat = subCategoriesList!.length - 1;
                                          });*/
                                        },
                                      ),
                                ),
                              ),
                            ),
                            visible: true,
                          ),
                          Visibility(
                            child: Container(
                              height: size.height * 0.09,
                              width: size.width,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.02),
                                child: ListView.builder(
                                  itemCount: subCategoriesList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                              padding: EdgeInsets.symmetric(
                                                vertical: size.height * 0.005,
                                                horizontal: size.width * 0.04),
                                              decoration: selectedCat == index
                                                ? const BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                                )
                                                : BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(30.0)),
                                                      border: Border.all(
                                                        width: size.width * 0.004,
                                                        color: Colors.black54
                                                      ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    subCategoriesList![index]!.title!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: size.height * 0.016,
                                                      color: selectedCat == index
                                                        ? Colors.white
                                                        : Colors.black54
                                                    ),
                                                  )),
                                            ),
                                            onTap: () {
                                              callSubCategoryApi(subCategoriesList![index]!.transId!);
                                              categoriesLocalList!.add(SubCategoriesLocal(
                                                  id: subCategoriesList![index]!.transId!,
                                                  title: subCategoriesList![index]!.title!
                                              ));
                                              setState(() {
                                                selectedCat = index;
                                                print("index1== "+categoriesLocalList!.length.toString());
                                                topSelectedCat = categoriesLocalList!.length - 1;
                                                print("index2== "+topSelectedCat.toString());
                                              });
                                            },
                                  ),
                                ),
                              ),
                            ),
                            visible: isSubCategories,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.06),
                              child: productCount != 0
                                ? GridView.count(
                                  primary: false,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  crossAxisSpacing: size.width * 0.04,
                                  mainAxisSpacing: 0,
                                  crossAxisCount: 2,
                                  controller: ScrollController(keepScrollOffset: false),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: List.generate(productsList!.length,
                                      (index) {
                                    return GridViewNewCard(
                                      productName: productsList![index]!.title!,
                                      price: productsList![index]!.price!,
                                      productSize: productsList![index]!.productSize!,
                                      icon: productsList![index]!.image!,
                                      color: productsList![index]!.colorCode!,
                                      onTap: () {
                                        Navigator.push(context, AppRoutes().productsDetailScreen(
                                          productsList![index]!.transId!,
                                          productsList![index]!.price!,
                                        ));
                                        print('trans_id == '+productsList![index]!.transId!.toString());
                                      },
                                    );
                                  }))
                                : Center(child: const Text('no_products_tr').tr()),
                            ),
                          )
                        ],
                      ),
                    ),)
                : Center(child: const Text('no_internet_tr').tr())
        )
    );
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
