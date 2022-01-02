import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class NavMainBody extends StatefulWidget {
  const NavMainBody({Key? key}) : super(key: key);

  @override
  _NavMainBodyState createState() => _NavMainBodyState();
}

class _NavMainBodyState extends State<NavMainBody> {

  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  int _currentIndex = 0;
  String title = 'app_name_tr';
  String meTitle = 'me_tr';
  bool? isSwitched = false;
  int? _langValue =  0;
  bool? isUserActive = true;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    // TestScreen(),
    const CategoryScreen(isAppBar: false,),
    const ContestAndCampaignsScreen(isAppBar: false,),
    const ProductsScreen(isAppBar: false,),
    const MeScreen()
  ];

  void _onItemTapped(int value) {

    switch (value) {
      case 0:
        title = 'app_name_tr';
        setState(() => _currentIndex = value);
        break;
      case 1:
        title = 'categories_tr';
        setState(() => _currentIndex = value);
        break;
      case 2:
        title = 'campaigns_tr';
        setState(() => _currentIndex = value);
        break;
      case 3:
        title = 'products_tr';
        setState(() => _currentIndex = value);
        break;
      case 4:
        if(isUserActive == true){
          print('userIsActive== '+isUserActive.toString());
          title = meTitle;
          setState(() => _currentIndex = value);
        }else{
          /*showDialog(context: context, builder: (BuildContext context) {
            return const LoginDialog();
          });*/
          Navigator.pushReplacement(context, AppRoutes().loginScreen,);
        }
        break;
    }
    // setState(() => _currentIndex = value);
  }

  @override
  void initState() {
    /*EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      setState(() {

      });
    });*/
    getUser();
    super.initState();
  }

  void getUser() async{
    isUserActive = await _sharedPref.getIsUserActive();
    isUserActive == true ? meTitle = 'me_tr': meTitle = 'login_tr';
    setState(() {});
    print('isUserActive= '+isUserActive.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
          automaticallyImplyLeading: true, //for add/remove back arrow
          title: Center(child: Text(title, textAlign: TextAlign.center,).tr()),
          // title: Text(title).tr(),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () async{
                _langValue = await _sharedPref.getIsEngActive() == true ? 1: 0;
                showDialog(context: context, builder: (BuildContext context) {
                  return AppLangChange(currentLang: _langValue,);
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.language),
              ),
            ),
          ]),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            label: tr('home_tr'),
            icon:  const Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: tr('categories_tr'),
            icon: const Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: tr('campaigns_tr'),
            icon: const Icon(Icons.campaign_outlined),
          ),
          BottomNavigationBarItem(
            label: tr('products_tr'),
            icon: const Icon(Icons.assignment_outlined),
          ),
          BottomNavigationBarItem(
            label: tr(meTitle),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
