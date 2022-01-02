import 'package:fusteka_icecreem/views/changePassword/components/app_change_pass_text_field.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ChangePassBody extends StatefulWidget {
  const ChangePassBody({Key? key}) : super(key: key);

  @override
  _ChangePassBodyState createState() => _ChangePassBodyState();
}

class _ChangePassBodyState extends State<ChangePassBody> {
  final _formKey = GlobalKey<FormState>();
  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  String? userId = '';


  callChangePassApi(){
    var changePassPro = context.read<ChangePassProvider>();
    _appFunctions.startLoading();
    final service = ApiServices();
    service.apiChangePass(context, userId).then((value){
      if(value.success == true){
        changePassPro.clearAllFields();
        print('Success ================');
        _appFunctions.loadingDismiss();
        _appFunctions.successMsg(('pass_update_success_tr').tr());
        _sharedPref.clear();
        Navigator.pushReplacement(context, AppRoutes().loginScreen,);
      }else{
        print('data not found!');
        _appFunctions.loadingDismiss();
        _appFunctions.errorMsg(('check_old_pass_tr').tr());

      }
    });
  }



  @override
  void initState() {
    getPrefData();
    super.initState();
  }

  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    super.dispose();
  }

  getPrefData() async{
    userId = await _sharedPref.getUserId();
    print('userId=='+userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var changePassPro = context.read<ChangePassProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, //for add/remove back arrow
        title: Center(child: const Text('change_pass_tr', textAlign: TextAlign.center).tr()),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: const [
          Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
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
                    /*SizedBox(
                        child: Image.asset(
                          AppAssets.iceCream,
                          height: size.height * 0.2,
                          width: size.width * 0.3,
                          fit: BoxFit.fill,
                        ),
                        // child: AssetImage(AppAssets.iceCream)
                    ),*/
                    // SizedBox(height: size.height * 0.01,),
                    SizedBox(
                        width: size.width,
                        child: Text('create_new_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading, color: AppColors.appColor),).tr()),
                    SizedBox(height: size.height * 0.02,),
                    SizedBox(
                        width: size.width,
                        child: Text('pass_should_dif_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent),).tr()
                    ),
                    SizedBox(height: size.height * 0.04,),
                    SizedBox(
                        width: size.width,
                        child: Text('old_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                    ),
                    SizedBox(height: size.height * 0.01,),
                    AppChangePassTextField(
                      controller: changePassPro.oldPassController,
                      label: ('type_old_pass_tr').tr(),
                      isOldPass: true,
                      isNewPass: false,
                      isRePass: false,
                    ),
                    SizedBox(height: size.height * 0.03,),
                    SizedBox(
                        width: size.width,
                        child: Text('new_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                    ),
                    SizedBox(height: size.height * 0.01,),
                    AppChangePassTextField(
                      controller: changePassPro.newPassController,
                      label: ('type_new_pass_tr').tr(),
                      isOldPass: false,
                      isNewPass: true,
                      isRePass: false,
                    ),
                    SizedBox(height: size.height * 0.03,),
                    SizedBox(
                        width: size.width,
                        child: Text('confirm_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                    ),
                    SizedBox(height: size.height * 0.01,),
                    AppChangePassTextField(
                      controller: changePassPro.rePassController,
                      label: ('hint_c_pass_tr').tr(),
                      isOldPass: false,
                      isNewPass: false,
                      isRePass: true,
                    ),
                    SizedBox(height: size.height * 0.06,),
                    SizedBox(
                      width: size.width,
                      child: CustomElevationBtn(
                        title: ('reset_pass_tr').tr(),
                        bgColor: AppColors.appColor,
                        textColor: Colors.white,
                        textSize: size.height * AppConstants.btnTextSize,
                        verPadding: size.height * AppConstants.btnVerPadding,
                        onTap: (){
                          if (_formKey.currentState!.validate()) {
                            callChangePassApi();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ),
      ),
    );
  }

}
