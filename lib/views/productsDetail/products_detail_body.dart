import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ProductInfo {
  const ProductInfo({required this.title, required this.content});
  final String title;
  final String content;
}

/*const List<ProductInfo> productInfoList = <ProductInfo>[
  ProductInfo(title: 'Description', content: 'Ice cream is a sweetened frozen food typically eaten as a snack or dessert. It may be made from dairy milk or cream and is flavoured with a sweetener.'),
  ProductInfo(title: 'Nutritional Information', content: 'Ice cream is a sweetened frozen food typically eaten as a snack or dessert. It may be made from dairy milk or cream and is flavoured with a sweetener.'),
];*/

class ProductsDetailBody extends StatefulWidget {
  final String productId;
  final String price;
  const ProductsDetailBody({Key? key, required this.productId, required this.price}) : super(key: key);


  @override
  _ProductsDetailBodyState createState() => _ProductsDetailBodyState(productId: productId, price: price);
}

class _ProductsDetailBodyState extends State<ProductsDetailBody> with SingleTickerProviderStateMixin {

  final String productId;
  final String price;
  _ProductsDetailBodyState({required this.productId, required this.price});
  int _current = 0;
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final AppFunctions _appFunctions = AppFunctions();
  SingleProduct? singleProduct = SingleProduct();
  AppViewModels listAppViewModel = AppViewModels();
  List<String>? sliderImages = [];
  List<NetworkImage> images = <NetworkImage>[];
  List<ProductInfo> productInfoList = [];



  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true, //for add/remove back arrow
        title: Center(child: const Text('pro_detail_tr', textAlign: TextAlign.center).tr()),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.white,
        actions: const [
          Text(''),
        ],
      ),
        body: SafeArea(
            child: _connectionStatus
                ? Center(
                  child: FutureBuilder(
                future: listAppViewModel.fetchSingleProduct(productId),
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
                        if(listAppViewModel.singleProduct != null){
                          listAppViewModel.singleProduct!.description = listAppViewModel.singleProduct!.description ?? '';
                          listAppViewModel.singleProduct!.nutritionalInfo = listAppViewModel.singleProduct!.nutritionalInfo ?? '';
                          productInfoList.clear();
                          productInfoList.add(ProductInfo(title: 'description_tr', content: listAppViewModel.singleProduct!.description!));
                          productInfoList.add(ProductInfo(title: 'nut_info_tr', content: listAppViewModel.singleProduct!.nutritionalInfo!));
                          /*if(listAppViewModel.singleProduct!.description!.isNotEmpty){
                            productInfoList.add(ProductInfo(title: 'description_tr', content: listAppViewModel.singleProduct!.description!));
                          }
                          if(listAppViewModel.singleProduct!.nutritionalInfo!.isNotEmpty){
                            productInfoList.add(ProductInfo(title: 'nut_info_tr', content: listAppViewModel.singleProduct!.nutritionalInfo!));
                          }*/
                          _appFunctions.loadingDismiss();
                          return Container(
                            height: size.height,
                            width: size.width,
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.32,
                                  width: size.width,
                                  color: AppColors.white,
                                  child: Center(
                                      child: SizedBox(
                                        // margin: EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
                                        height: size.height,
                                        width: size.width,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.height * 0.03),
                                          child: ListView(
                                            children: [
                                              CarouselSlider(
                                                options: CarouselOptions(
                                                    // aspectRatio: 12 / 7,
                                                    enlargeCenterPage: true,
                                                    enableInfiniteScroll: true,
                                                    initialPage: 2,
                                                    autoPlayCurve: Curves.fastOutSlowIn,
                                                    autoPlay: true,
                                                    viewportFraction: 0.8,
                                                    ),
                                                items: imageSliders(listAppViewModel.singleProduct!.images, size),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    height: size.height * 0.040,
                                    width: size.width,
                                    color: AppColors.singleProductBg,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: listAppViewModel.singleProduct!.images!.map((image) {
                                        int index = listAppViewModel.singleProduct!.images!.indexOf(image);
                                        print('index== '+index.toString());
                                        return Container(
                                          width: 10.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _current == index
                                                  ? Colors.pink
                                                  : const Color.fromRGBO(0, 0, 0, 0.4)),
                                        );
                                      },
                                      ).toList(), // this was the part the I had to add
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.height * 0.025),
                                  child: SizedBox(
                                      width: size.width,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(flex: 1, child: Text(listAppViewModel.singleProduct!.title!, style: TextStyle(color: Colors.grey.shade800, fontSize: size.height * 0.018, fontWeight: FontWeight.w700), textAlign: TextAlign.start).tr()),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(price+' IQD', style: TextStyle(color: AppColors.proQuantityPrice, fontSize: size.height * 0.020, fontWeight: FontWeight.w800), textAlign: TextAlign.end).tr(),
                                                  SizedBox(height: size.height * 0.03, child: const VerticalDivider(color: AppColors.proQuantityPrice)),
                                                  Text(listAppViewModel.singleProduct!.productSize!+' ml', style: TextStyle(color: AppColors.proQuantityPrice, fontSize: size.height * 0.020, fontWeight: FontWeight.w800), textAlign: TextAlign.end).tr(),
                                                ],
                                              )),
                                        ],
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
                                    child: Center(
                                      child: ContainedTabBarView(
                                        tabs: productInfoList.map((ProductInfo productInfo) {
                                          return Tab(
                                            text: (productInfo.title).tr(),
                                          );
                                        }).toList(),
                                        tabBarProperties: TabBarProperties(
                                          labelStyle: TextStyle(fontSize: size.height * 0.020),
                                          height: 32.0,
                                          indicatorColor: AppColors.proQuantityPrice,
                                          indicatorWeight: 2.0,
                                          labelColor: AppColors.proQuantityPrice,
                                          unselectedLabelColor: Colors.grey.shade700,
                                        ),
                                        views: productInfoList.map((ProductInfo productInfo) {
                                          print(productInfo.title);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,//.horizontal
                                                child: Html(data: productInfo.content,)
                                            ),
                                          );
                                        }).toList(),
                                          onChange: (index) {
                                            print(index);
                                        }
                                      ),
                                    ),
                                  ),
                                )
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


  List<Widget> imageSliders(List<String>? list, Size size){
    return list!.map((item) =>
        FadeInImage.assetNetwork(
            placeholder: AppAssets.horPlaceholder,
            image: item,
            fit: BoxFit.fill,
        ))
        .toList();
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


final List<String> imgList1 = [
  AppAssets.slide2,
  AppAssets.slide1,
  AppAssets.slide3,
];
