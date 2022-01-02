import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({Key? key}) : super(key: key);

  @override
  _NewSplashScreenState createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  final SharedPref _sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    bool lightMode = MediaQuery
        .of(context)
        .platformBrightness == Brightness.light;
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.newSplash),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  startScreen() async{
    bool? isEng = await _sharedPref.getIsEngActive();
    bool? isUser = await _sharedPref.getIsUserActive();
    print('get isEng== $isEng');
    print('get isUser== $isUser');
    isEng == true ? context.setLocale(const Locale('en','US')): context.setLocale(const Locale('ar','IQ'));
    if(isUser == true){
      Navigator.pushReplacement(context, AppRoutes().navMainScreen);
    }else{
      Navigator.pushReplacement(context, AppRoutes().loginScreen);
    }
  }
}


class Init {
  Init._();
  static final instance = Init._();
  final Future<FirebaseApp> _auth = Firebase.initializeApp();
  Future initialize() async {
    //await _auth;
    // await startScreen();
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }

}
