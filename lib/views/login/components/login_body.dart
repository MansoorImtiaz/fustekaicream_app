import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/views/login/components/login_phone_or_pass_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  AppStorage storage =  AppStorage();
  List<Cities?>? citiesModelList = [];
  String email = '';
  String pass = '';
  int? _langValue =  0;

  @override
  void initState() {
    getCitiesFromDB();
    super.initState();
  }


  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    super.dispose();
  }

  getCitiesFromDB() async{
    _appFunctions.startLoading();
    bool? isUser = await _sharedPref.getIsUserActive();
    _appFunctions.checkInternet().then((internet) async {
      if (internet){
        if (isUser == false) {
          final service = ApiServices();
          await service.fetchCitiesAPI(context, 'en');
          await service.fetchCitiesAPI(context, 'ar');
          await storage.getCities(context, 'en');
          await storage.getCities(context, 'ar');
        }
        _appFunctions.loadingDismiss();
      }else{
        _appFunctions.noInternetMsg(('no_internet_tr').tr());
      }
    });
  }

  callLoginApi(LoginProvider loginPro){
    _appFunctions.checkInternet().then((internet) {
      if (internet) {
        _appFunctions.startLoading();
        final service = ApiServices();
        service.apiLogin(
            loginPro.forAPIEmailOrPassController.text,
            loginPro.passController.text
        ).then((value){
          if (value != null) {
            if(value.success == true) {
              loginPro.clearAllFields();
              print('Success ================');
              print(value.data?.token);
              _sharedPref.setUserId(value.data!.user!.id.toString());
              _sharedPref.setToken(value.data!.token);
              _sharedPref.setIsUserActive(true);
              _appFunctions.loadingDismiss();
              _appFunctions.successMsg(('login_success_msg_tr').tr());
              Navigator.pushReplacement(
                context,
                AppRoutes().navMainScreen,
              );
            } else {
              if(value.message!.contains('Inactive user')){
                _appFunctions.loadingDismiss();
                _appFunctions.errorMsg(('login_inactive_msg_tr').tr());
                /*if(loginPro.forAPIEmailOrPassController.text.isNotEmpty){
                  loginPro.emailController.text = loginPro.forAPIEmailOrPassController.text;
                }*/
              }else if(value.message!.contains('Unauthorised')){
                print('data not found!');
                _appFunctions.loadingDismiss();
                _appFunctions.errorMsg(('login_error_msg_tr').tr());
                /*if(loginPro.forAPIEmailOrPassController.text.isNotEmpty){
                  loginPro.emailController.text = loginPro.forAPIEmailOrPassController.text;
                }*/
              }else{
                _appFunctions.loadingDismiss();
                _appFunctions.errorMsg(('signup_error_msg_tr').tr());
              }
                      }
          } else {
            _appFunctions.errorMsg(('signup_error_msg_tr').tr());
          }
        });
      }else{
        _appFunctions.noInternetMsg(('no_internet_tr').tr());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.currentScreen = AppConstants.login;
    Size size = MediaQuery.of(context).size;
    var loginPro = context.read<LoginProvider>();
    var signupPro = context.read<SignUpProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
          automaticallyImplyLeading: true, //for add/remove back arrow
          title: Center(child: const Text('app_name_tr', textAlign: TextAlign.center).tr()),
          // title: Text(title).tr(),
          backgroundColor: AppColors.appColor,
          foregroundColor: AppColors.white,
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
          ],
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.appBG),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * AppConstants.screenVerPadding, horizontal: size.width * AppConstants.screenHorPadding,),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Text('skip_tr', style: TextStyle(color: AppColors.appColor, fontSize: size.height * 0.018), textAlign: TextAlign.end).tr(),
                              onTap: (){
                                Navigator.pushReplacement(context, AppRoutes().navMainScreen,);
                              },
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: size.height * 0.01,),
                    SizedBox(
                        width: size.width,
                        child: Text('login_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading),).tr()),
                    SizedBox(height: size.height * AppConstants.lonGapBWWidgets,),
                    SizedBox(
                      width: size.width,
                      child: Text('email_or_phone_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                    ),
                    SizedBox(height: size.height * 0.01,),
                    LoginPhoneOrPassTextField(
                      controller: loginPro.emailController,
                      keyboard: TextInputType.text,
                      label: tr('hint_email_or_phone_tr'),
                    ),
                    SizedBox(height: size.height * AppConstants.lonGapBWWidgets,),
                    SizedBox(
                        width: size.width,
                        child: Text('password_login_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                    ),
                    SizedBox(height: size.height * 0.01,),
                    LoginPassTextField(
                      controller: loginPro.passController,
                      label: tr('hint_pass_tr'),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Text('verify_your_account_tr', style: TextStyle(color: AppColors.appColor, fontSize: size.height * AppConstants.textFieldTitle, fontWeight: FontWeight.w500), textAlign: TextAlign.end).tr(),
                              onTap: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                loginPro.emailController.text = '';
                                loginPro.passController.text = '';
                                signupPro.phoneNoController.text = '';
                                signupPro.forFirebasePhoneController.text = '';
                                signupPro.forAPIPhoneController.text = '';
                                Navigator.push(context, AppRoutes().otpVerifyScreen(false),);
                              },
                            ),
                            GestureDetector(
                              child: Text('forgot_pass_tr', style: TextStyle(color: AppColors.appColor, fontSize: size.height * AppConstants.textFieldTitle, fontWeight: FontWeight.w500), textAlign: TextAlign.end).tr(),
                              onTap: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                loginPro.emailController.text = '';
                                loginPro.passController.text = '';
                                signupPro.phoneNoController.text = '';
                                signupPro.forFirebasePhoneController.text = '';
                                signupPro.forAPIPhoneController.text = '';
                                Navigator.push(context, AppRoutes().otpVerifyScreen(true),);
                              },
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: size.height * AppConstants.lonGapBWWidgets,),
                    SizedBox(
                      width: size.width,
                      child: CustomElevationBtn(
                        title: tr('login_tr'),
                        bgColor: AppColors.appColor,
                        textColor: Colors.white,
                        textSize: size.height * AppConstants.btnTextSize,
                        verPadding: size.height * AppConstants.btnVerPadding,
                        onTap: (){
                          if (_formKey.currentState!.validate()) {
                            callLoginApi(loginPro);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.06,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("no_account_tr", style: TextStyle(color: Colors.grey, fontSize: size.height * AppConstants.screenTopHeadingContent,)).tr(),
                        GestureDetector(
                          child: Text("signup_tr", style: TextStyle(color: AppColors.appColor, fontSize: size.height * AppConstants.screenTopHeadingContent, fontWeight: FontWeight.w800)).tr(),
                          onTap: (){
                            Navigator.push(context, AppRoutes().signUpScreen,);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
