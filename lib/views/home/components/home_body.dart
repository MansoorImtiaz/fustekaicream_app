import 'package:fusteka_icecreem/core/hooks/hooks.dart';

final List<String> imgList = [
  AppAssets.slide2,
  AppAssets.slide1,
  AppAssets.slide3,
];

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  List<Widget> imageSliders(List<LocalHomeSliderModel>? list, Size size) {
    return list!.map((item) =>
        Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    placeholder: AppAssets.horPlaceholder,
                    image: item.image!,
                    fit: BoxFit.fill,
                    width: size.width
                  ),
                  // Image.asset(AppAssets.placeholder, fit: BoxFit.cover, width: size.width),
                  /*Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),*/
                ],
              )),
        ))
        .toList();
  }
  int _current = 0;
  AppStorage storage =  AppStorage();
  final AppFunctions _appFunctions = AppFunctions();
  final service = ApiServices();


  @override
  void initState() {
    super.initState();
    var signUpPro = context.read<SignUpProvider>();
    if(signUpPro.homeSliderList.isEmpty){
      getSliderFromDB();
      print('run====');
    }

  }


  @override
  void dispose() {
    super.dispose();
    _appFunctions.loadingDismiss();
  }

  getSliderFromDB() async{
      _appFunctions.checkInternet().then((internet) async {
        if (internet){
          final service = ApiServices();
          await service.fetchHomeSliderAPI(context);
          await storage.getHomeSliderList(context);
        }else{
          await storage.getHomeSliderList(context);
        }
        setState(() {

        });
        _appFunctions.loadingDismiss();
      });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signUpPro = context.read<SignUpProvider>();
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 250) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SafeArea(
            child: Container(
                height: size.height,
                width: size.width,
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    signUpPro.homeSliderList.isNotEmpty
                        ?SizedBox(
                          height: size.height * 0.24,
                          width: size.width,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                    aspectRatio: 16 / 7,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                    initialPage: 2,
                                    autoPlay: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: imageSliders(signUpPro.homeSliderList, size),
                              )
                            ],
                          )
                        )
                        :SizedBox(
                          height: size.height * 0.24,
                          width: size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: size.height * 0.0, horizontal: size.width * 0.1),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      child: Image.asset(AppAssets.horPlaceholder, fit: BoxFit.fill, width: size.width)),
                                ),
                              )
                            ],
                          )
                        ),
                    SizedBox(
                      height: size.height * 0.040,
                      width: size.width,
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: signUpPro.homeSliderList.map(
                              (image) {
                            int index = signUpPro.homeSliderList.indexOf(image);
                            return Container(
                              width: 8.0,
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
                    Expanded(
                      child: Container(
                          height: size.height,
                          width: size.width,
                          // color: Colors.blueAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                            child: GridView.count(
                              primary: false,
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisSpacing: size.width * 0.02,
                              mainAxisSpacing: size.height * 0.02,
                              crossAxisCount: 2,
                              children: <Widget>[
                                HomeGridCard(
                                  productName: 'product_categories_tr',
                                  icon: AppAssets.homeCategoriesIcon,
                                  color: '#FFBE96',
                                  onTap: () {
                                    Navigator.push(context, AppRoutes().categoriesScreen(true));
                                  },
                                ),
                                HomeGridCard(
                                  productName: 'contest_campaigns_tr',
                                  icon: AppAssets.homeContestIcon,
                                  color: '#80F0BC',
                                  onTap: () {
                                    Navigator.push(context, AppRoutes().contestAndCampaignsScreen(true));
                                  },
                                ),
                                HomeGridCard(
                                  productName: 'products_tr',
                                  icon: AppAssets.homeProductsIcon,
                                  color: '#FFEE7E',
                                  onTap: () {
                                    Navigator.push(context, AppRoutes().productsScreen(true));
                                  },
                                ),
                                HomeGridCard(
                                  productName: 'gallery_tr',
                                  icon: AppAssets.homeGalleryIcon,
                                  color: '#90CAFD',
                                  onTap: () {
                                    Navigator.push(context, AppRoutes().campaignsGalleryScreen);
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                )),
          );
        }
      ),
    );
  }
}


