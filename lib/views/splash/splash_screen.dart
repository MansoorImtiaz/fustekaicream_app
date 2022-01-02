import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/core/themes/app_themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SharedPref _sharedPref =  SharedPref();

  @override
  void initState() {
    super.initState();
    // AppThemes.splash();
    Future.delayed(const Duration(milliseconds: 3000),(){
      // Navigator.pushReplacement(context, AppRoutes().floorDataScreen(widget.dao));
      startScreen();

    });
  }

  @override
  void dispose(){
    // AppThemes.customTheme();
    super.dispose();
  }


  startScreen() async{
    bool? isEng = await _sharedPref.getIsEngActive();
    bool? isUser = await _sharedPref.getIsUserActive();
    print('get isEng== $isEng');
    print('get isUser== $isUser');
    isEng == true ? context.setLocale(const Locale('en','US')): context.setLocale(const Locale('ar','IQ'));
    Navigator.pushReplacement(context, AppRoutes().navMainScreen);
    /*if(isUser == true){
      Navigator.pushReplacement(context, AppRoutes().navMainScreen);
    }else{
      Navigator.pushReplacement(context, AppRoutes().loginScreen);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          /*child: Column(
            children: [
              const Spacer(),
              Image.asset(AppAssets.appIcon,
                height: size.height * 0.15,
                fit: BoxFit.cover,
              ),
              const Spacer(),
            ],
          ),*/
        ),
      ),
    );
  }
}
