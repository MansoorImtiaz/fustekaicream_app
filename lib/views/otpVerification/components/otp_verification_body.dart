import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class OTPVerifyBody extends StatefulWidget {
  final bool? isForgotPass;
  const OTPVerifyBody({Key? key, required this.isForgotPass}) : super(key: key);

  @override
  _OTPVerifyBodyState createState() => _OTPVerifyBodyState(isForgotPass: isForgotPass);
}

class _OTPVerifyBodyState extends State<OTPVerifyBody> {

  final bool? isForgotPass;
  _OTPVerifyBodyState({required this.isForgotPass});
  int start = 30;
  bool wait = false;
  bool isOTPSent = false;
  bool isWaitForOTP = false;
  String btnName = 'send_tr';
  TextEditingController phoneController = TextEditingController();
  String verificationIdReceived = '';
  String smsCode = '';
  String currentCode = '';
  int? _langValue =  0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();


  Future<void> verifyPhoneNo(String phoneNumber, Function setData) async{
    try {
      await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential){
            _auth.signInWithCredential(credential).then((value){
              _appFunctions.customSnackBar(context, 'logged_success_tr', Colors.deepOrange.shade700);

            });
          },
          verificationFailed: (FirebaseAuthException exception){
            _appFunctions.customSnackBar(context, exception.message.toString(), Colors.deepOrange.shade700);
          },
          codeSent: (String verificationId, int? resentToken){
            _appFunctions.customSnackBar(context, 'code_sent_tr', Colors.green.shade700);
            setData(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId){
            _appFunctions.customSnackBar(context, 'time_out_tr', Colors.deepOrange.shade700);
            isOTPSent = false;
            isWaitForOTP = false;
            setState(() {});
          }
      );
    } on FirebaseAuthException catch(e) {

      _appFunctions.customSnackBar(context, 'code_not_valid_tr', Colors.deepOrange.shade700);
    }
  }

  void setData(String verificationId){
    setState(() {
      verificationIdReceived = verificationId;
    });
    startTimer();
  }

  Future<void> signInwithPhoneNumber(String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      _appFunctions.customSnackBar(context, 'code_valid_tr', Colors.green.shade700);
      if (isForgotPass == true) {
        Navigator.pushReplacement(context, AppRoutes().forgotPassScreen);
      }else{
        callPhoneVerifyApi();
      }
    } catch (e) {
      print(e.toString());
      if(e.toString().contains('session-expired')){
        _appFunctions.customSnackBar(context, 'code_expired_tr', Colors.deepOrange.shade700);
      }else if(e.toString().contains('invalid-verification-id')){
        _appFunctions.customSnackBar(context, 'code_not_found_tr', Colors.deepOrange.shade700);
      }else if(e.toString().contains('invalid-verification-code')){
        _appFunctions.customSnackBar(context, 'code_invalid_tr', Colors.deepOrange.shade700);
      }else{
        _appFunctions.customSnackBar(context, 'try_again_tr', Colors.deepOrange.shade700);
      }
    }
  }


  String? getFullNumber() {
    var signupPro = context.read<SignUpProvider>();
    String phone = signupPro.forFirebasePhoneController.text;
    if(phone.startsWith('+')){
      String withoutPlus = phone.substring(1);
      // signupPro.phoneNoController.text = '00'+withoutPlus; //was commented
      return '00'+withoutPlus;
    }
  }

  callIsValidNumberApi(SignUpProvider signUpPro){
    _appFunctions.startLoading();
    final service = ApiServices();
    service.apiIsValidNumber(context, signUpPro).then((value){
      if(value.success == true){
        print('Success ================');
        _appFunctions.loadingDismiss();
        if(isForgotPass == true){
          proceedForOTP(signUpPro);
        }else{
          _appFunctions.infoMsg(('already_verify_tr').tr());
        }
      }else{
        _appFunctions.loadingDismiss();
        if(value.message!.contains('User not found')){
          print('data not found!');
          _appFunctions.errorMsg(('user_not_found_tr').tr());
        }else{
          print('Inactive user');
          if(isForgotPass == true){
            _appFunctions.errorMsg(('account_not_verified_tr').tr());
          }else{
            proceedForOTP(signUpPro);
          }
        }
      }
    });
  }

  void proceedForOTP(SignUpProvider signUpPro) {
    startTimer();
    setState(() {
      start = 30;
      wait = true;
      isWaitForOTP = true;
      btnName = ('resend_tr').tr();
      verifyPhoneNo(signUpPro.forFirebasePhoneController.text, setData);
    });
  }

  callPhoneVerifyApi(){
    var signupPro = context.read<SignUpProvider>();
    _appFunctions.checkInternet().then((internet) {
      if (internet) {
        _appFunctions.startLoading();
        final service = ApiServices();
        service.apiPhoneVerify({
          "phone": signupPro.forAPIPhoneController.text,
        }).then((value){
          if (value != null) {
            print('phoneNo== '+signupPro.forAPIPhoneController.text);
            if(value.success == true){
              signupPro.emailController.text = '';
              signupPro.phoneNoController.text = '';
              signupPro.clearAllFields();
              print('Success ================');
              print(value.data?.token);
              _sharedPref.setToken(value.data?.token);
              _sharedPref.setIsUserActive(true);
              _appFunctions.loadingDismiss();
              _appFunctions.successMsg(('login_success_msg_tr').tr());
              Navigator.pushReplacement(context, AppRoutes().loginScreen,);
            }else{
              print('data not found!');
              _appFunctions.loadingDismiss();
              _appFunctions.errorMsg(('invalid_phone_msg_tr').tr());
              isOTPSent = false;
              isWaitForOTP = false;
              setState(() {});
            }
          } else {
            _appFunctions.errorMsg(('server_error_msg_tr').tr());
          }
        });
      }else{
        _appFunctions.noInternetMsg(('no_internet_tr').tr());
      }
    });
  }

  /*void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }*/


  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signupPro = context.read<SignUpProvider>();
    return Scaffold(
      appBar: AppBar(
        // leading: const Text(''),
        // automaticallyImplyLeading: true, //for add/remove back arrow
        centerTitle: true,
        title: Center(child: Text( isForgotPass == true
            ?'create_pass_tr'
            :'verify_account_tr',
            textAlign: TextAlign.center).tr()),
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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * AppConstants.screenVerPadding, horizontal: size.width * AppConstants.screenHorPadding,),
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        AppAssets.otpImage,
                        height: size.height * 0.15,
                        width: size.width * 0.25,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03,),
                    SizedBox(
                        width: size.width,
                        child: Text(
                          ('otp_verify_tr').tr(),
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading, color: AppColors.appColor, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: size.height * 0.01,),
                    SizedBox(
                        width: size.width,
                        child: Text( isForgotPass == true
                            ?('register_for_pass_tr').tr()
                            :('register_for_account_tr').tr(),
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: AppColors.textLightGray, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: size.height * 0.03,),
                    sendOtpField(signupPro, size),
                    SizedBox(height: size.height * 0.03,),
                    Visibility(
                      visible: isOTPSent,//isOTPSent
                      child: otpSeparator(size),
                    ),
                    SizedBox(height: size.height * 0.03,),
                    Visibility(
                      visible: isOTPSent,//isOTPSent
                      child: otpField(size)
                    ),
                    SizedBox(height: size.height * 0.03,),
                    Visibility(
                        visible: isWaitForOTP,//isWaitForOTP
                        child: otpTimer(size)
                    ),
                    SizedBox(height: size.height * 0.04,),
                    Visibility(
                      visible: isOTPSent,//isOTPSent
                      child: SizedBox(
                        width: size.width,
                        child: CustomElevationBtn(
                          title: tr('submit_tr'),
                          bgColor: AppColors.appColor,
                          textColor: Colors.white,
                          textSize: size.height * AppConstants.btnTextSize,
                          verPadding: size.height * AppConstants.btnVerPadding,
                          onTap: (){
                            if (currentCode.length == 6) {
                              signInwithPhoneNumber(verificationIdReceived, smsCode, context);
                            }else{
                              _appFunctions.customSnackBar(context, 'enter_six_digits_code_tr', Colors.deepOrange.shade700);
                            }

                          },
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sendOtpField(SignUpProvider signUpPro, Size size){
      String? validationMsg = 'field_required_tr';
      String? userValue = '';
      /*if(isForgotPass == false){
        signupPro.phoneNoController.text = signupPro.tempPhoneNoController.text;
      }*/
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(validationMsg);
        }else if (value.length < 11) {
          return tr('should_11_digits_tr');
        }else{
          userValue = value;
          if(_appFunctions.isNumeric(userValue!)){
            if(userValue!.startsWith('+')){
              if (userValue!.startsWith('+964')) {
                if(userValue!.length == 14){
                  //true
                  signUpPro.forFirebasePhoneController.text = userValue!;
                  String withoutPlus = userValue!.substring(1);
                  signUpPro.forAPIPhoneController.text = '00'+withoutPlus;
                }else{
                  //false
                  return tr('enter_valid_no_tr');
                }
              }else{
                //false
                return tr('enter_valid_no_tr');
              }
            }else{
              if(userValue!.length > 9 && userValue!.length < 16){
                //true
                userValue = _appFunctions.getFinalNum(userValue!);
                if(userValue!.isNotEmpty){
                  print(userValue);
                  userValue = '+964' + userValue!;
                  signUpPro.forFirebasePhoneController.text = userValue!;
                  String withoutPlus = userValue!.substring(1);
                  signUpPro.forAPIPhoneController.text = '00'+withoutPlus;
                  print('Valid = '+_appFunctions.isPhoneValid(userValue!).toString());
                }else{
                  //false
                  return tr('enter_valid_no_tr');
                }
              }else{
                //false
                return tr('enter_valid_no_tr');
              }
            }
          }else{
            //false
            return tr('enter_valid_no_tr');
          }
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      controller: signUpPro.phoneNoController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: size.height * AppConstants.textFieldVerPadding, horizontal: size.width * AppConstants.textFieldHorPadding),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0),)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0),),
            borderSide: BorderSide(color: Colors.pink.shade200, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:const BorderRadius.all( Radius.circular(8.0),),
            borderSide: BorderSide(color: Colors.grey.shade700, width: 0.0),
          ),
          labelStyle: const TextStyle(
              color: AppColors.black,
              // fontSize: size.height * 0.022,
              fontWeight: FontWeight.normal
          ),
          prefixIcon: TextButton(
            onPressed: () {  },
            child: Text(
              "(+964)",
              style: TextStyle(color: Colors.grey.shade900, fontSize: size.height * AppConstants.screenTopHeadingContent,),
            ),
          ),
          suffixIcon: TextButton(
            onPressed: wait ? null : (){
              if (_formKey.currentState!.validate()) {
                FocusManager.instance.primaryFocus?.unfocus();
                callIsValidNumberApi(signUpPro);
              }
            },
            child: Text(
              btnName,
              style: TextStyle(color: wait ?  Colors.grey.shade400: AppColors.appColor, fontSize: size.height * AppConstants.screenTopHeadingContent, fontWeight: FontWeight.w500),
            ).tr(),
          ),
      ),
    );
  }

  void startTimer(){
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if(start == 0){
        setState(() {
          timer.cancel();
          wait = false;
          isOTPSent = true;
        });
      }else{
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpSeparator(Size size){
    return SizedBox(
      width: size.width -30,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black54,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              )
          ),
          Expanded(flex: 2,child: Text("enter_your_otp_tr", textAlign: TextAlign.center, style: TextStyle(color:  Colors.black, fontSize: size.height * AppConstants.screenTopHeadingContent),).tr()),
          Expanded(
            flex: 1,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black54,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              )
          ),
        ],
      ),
    );
  }

  Widget otpTimer(Size size){
    return RichText(
        text: TextSpan(
            children: [
              TextSpan(
                  text: ("timer_msg_tr").tr(),
                  style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color:  Colors.black,)
              ),
              TextSpan(
                  text: "00:$start",
                  style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color:  Colors.blueAccent, fontWeight: FontWeight.w500)
              ),
              TextSpan(
                  text: ("sec_tr").tr(),
                  style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color:  Colors.black,)
              ),
            ]
        )
    );
  }

  Widget otpField(Size size){
    return OTPTextField(
      length: 6,
      width: size.width,
      fieldWidth: size.width * 0.12,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: AppColors.white,
          borderColor: Colors.grey
      ),
      style: TextStyle(
          fontSize: size.height * AppConstants.textFieldTitle
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onChanged: (pin) {
        print("Changed: " + pin);
        currentCode = pin;
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
        smsCode = pin;
        /*setState(() {
          smsCode = pin;
        });*/
      },
    );
  }
}

