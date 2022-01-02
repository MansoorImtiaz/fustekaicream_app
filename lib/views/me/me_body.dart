import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class MeBody extends StatefulWidget {
  const MeBody({Key? key}) : super(key: key);

  @override
  _MeBodyState createState() => _MeBodyState();
}

class _MeBodyState extends State<MeBody> {

  final SharedPref _sharedPref =  SharedPref();
  final AppFunctions _appFunctions = AppFunctions();
  AppStorage storage =  AppStorage();

  @override
  void initState() {
    EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
    print (event.appLang);
    if(event.appLang.contains(AppConstants.me)){
      setState(() {});
    }
  });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUserProfileFromDB() async{
    // signupPro = context.read<SignUpProvider>();
    _appFunctions.startLoading();
    await storage.getUserProfile(context);
    // name = signupPro.viewNameUPController.text;
    _appFunctions.loadingDismiss();
    Navigator.push(context, AppRoutes().viewProfileScreen,);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppConstants.currentScreen = AppConstants.me;
    return Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.30,
                  width: size.width,
                  color: AppColors.singleProductBg,
                  child: Image.asset(
                    AppAssets.meHeader,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.04, horizontal: size.height * 0.04,),
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: Colors.amber,
                                    size: size.height * 0.035,
                                  ),
                                  SizedBox(width: size.width * 0.04,),
                                  Text('my_profile_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                ],
                              ),
                              onTap: (){
                                getUserProfileFromDB();
                              },
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Divider(
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(height: size.height * 0.01,),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock_outlined,
                                    color: Colors.deepPurple,
                                    size: size.height * 0.035,
                                  ),
                                  SizedBox(width: size.width * 0.04,),
                                  Text('change_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                ],
                              ),
                              onTap: (){
                                Navigator.push(context, AppRoutes().changePassScreen,);
                              },
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Divider(
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(height: size.height * 0.01,),
                            SizedBox(height: size.height * 0.01,),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                    size: size.height * 0.035,
                                  ),
                                  SizedBox(width: size.width * 0.04,),
                                  Text('logout_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                ],
                              ),
                              onTap: (){
                                _sharedPref.clear();
                                Navigator.pushReplacement(context, AppRoutes().loginScreen,);
                              },
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Divider(
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(height: size.height * 0.01,),
                          ],
                        )
                    ),
                  ),
                )
              ],
            )
          ),
        )
    );
  }
}
