import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {

  final _formKey = GlobalKey<FormState>();
  final String dateFormat = 'dd-MM-yyyy';
  String address = 'search';
  LocationWrapper locationWrapper = LocationWrapper();
  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  bool? isEng;

  String name = '';
  String surname = '';
  String city = '';
  String phoneNo = '';
  String email = '';
  String pass = '';
  String rePass = '';
  String dob = '';
  String gender = '';
  String location = '';

  AppStorage storage = AppStorage();
  final List<String> _genderList = [('txt_male_tr').tr(), ('txt_female_tr').tr()];
  String? _selectedGender;
  String? _selectedCity;

  int? _radioValue = 0;
  int? _langValue =  0;

  void _handleRadioValueChange(int? value) {
    var signupPro = context.read<SignUpProvider>();
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          signupPro.genderController.text = 'male';
          break;
        case 1:
          signupPro.genderController.text = 'female';
          break;
      }
    });
  }

  callSignUpApi(SignUpProvider signUpPro){
    _appFunctions.startLoading();
    final service = ApiServices();
    service.apiSignUp1(context).then((value){
      if(value.success == true){
        signUpPro.clearAllFields();
        print('Success ================');
        _appFunctions.loadingDismiss();
        _appFunctions.successMsg(('signup_success_msg_tr').tr());
        Navigator.pushReplacement(context, AppRoutes().otpVerifyScreen(false),);
      }else{
        if(value.message!.contains('Email already exist!')){
          _appFunctions.errorMsg(('email_exist_msg_tr').tr());
          /*if(signUpPro.tempPhoneNoController.text.isNotEmpty){
            signUpPro.phoneNoController.text = signUpPro.tempPhoneNoController.text;
          }*/
        }else{
          print('data not found!');
          _appFunctions.loadingDismiss();
          _appFunctions.errorMsg(('signup_error_msg_tr').tr());
          /*if(signUpPro.tempPhoneNoController.text.isNotEmpty){
            signUpPro.phoneNoController.text = signUpPro.tempPhoneNoController.text;
          }*/
        }
      }
    });
  }


  @override
  void initState() {
    setCurrentLang();
    EventBusUtils.getInstance().on<UpdateAppLanguage>().listen((event) {
      print (event.appLang);
      if(event.appLang.contains(AppConstants.signup)){
        setCurrentLang();
      }
    });
    super.initState();
  }

  setCurrentLang() async{
    isEng = await _sharedPref.getIsEngActive();
    print('isEng=='+isEng.toString());
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.currentScreen = AppConstants.signup;
    Size size = MediaQuery.of(context).size;
    var signupPro = context.read<SignUpProvider>();
    signupPro.genderController.text = 'male';
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // automaticallyImplyLeading: true, //for add/remove back arrow
          title: Center(
              child: const Text('app_name_tr').tr()),
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
          // title: Text(title).tr(),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                        width: size.width,
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height * AppConstants.screenVerPadding, horizontal: size.width * AppConstants.screenHorPadding,),
                             child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: size.width,
                                    child: Text('signup_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.04,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('first_name_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  AppSimpleTextField(
                                    controller: signupPro.nameController,
                                    keyboard: TextInputType.text,
                                    hintText: tr('hint_name_tr'),
                                    isName: true,
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('sur_name_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  OptionalTextField(
                                    controller: signupPro.surnameController,
                                    keyboard: TextInputType.text,
                                    label: tr('hint_surname_tr'),
                                    isSurname: true,
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('phone_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  PhoneTextField(
                                    controller: signupPro.phoneNoController,
                                    keyboard: TextInputType.number,
                                    label: tr('hint_phone_tr'),
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('email_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  OptionalTextField(
                                      controller: signupPro.emailController,
                                      label: tr('hint_email_tr'),
                                      keyboard: TextInputType.emailAddress,
                                      isEmail: true
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('password_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  SignUpPassTextField(
                                      controller: signupPro.passController,
                                      label: tr('hint_pass_tr'),
                                      isPass: true,
                                      isRePass: false
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('confirm_pass_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  SignUpPassTextField(
                                      controller: signupPro.rePassController,
                                      label: tr('hint_c_pass_tr'),
                                      isPass: false,
                                      isRePass: true
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('dob_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      _selectDate(context,signupPro);   // Call Function that has showDatePicker()
                                    },
                                    child: IgnorePointer(
                                      child: OptionalTextField(
                                        controller: signupPro.dobController,
                                        keyboard: TextInputType.text,
                                        label: tr('hint_dob_tr'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('gender_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  Container(
                                    width: size.width,
                                    padding: EdgeInsets.symmetric(vertical: size.height * 0.001, horizontal: size.width * 0.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                           borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                            border: Border.all(
                                              width: size.width * 0.0015, //                   <--- border width here
                                            ),
                                    ),
                                    child: radioButtons(size,signupPro),
                                  ),


                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('city_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  InkWell(
                                    onTap: (){
                                      showDialog(context: context, builder: (BuildContext context) {
                                        return AppCitiesDialog(citiesList: isEng == true ? signupPro.engCitiesList: signupPro.arabicCitiesList,);
                                      });
                                    },
                                    child: IgnorePointer(
                                      child: AppSimpleTextField(
                                        controller: signupPro.cityController,
                                        keyboard: TextInputType.text,
                                        hintText: tr('hint_city_tr'),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('location_tr', style: TextStyle(fontSize: size.height * AppConstants.textFieldTitle),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  LocationTextField(
                                    controller: signupPro.locationController,
                                    keyboard: TextInputType.text,
                                    label: tr('hint_location_tr'),
                                    onTap: () async {
                                      Position position = await _getGeoLocationPosition();
                                      location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                                      getAddressFromLatLong(position);
                                      signupPro.locationController.text = locationWrapper.fullAddress??"";
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.06),
                    child: SizedBox(
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomElevationBtn(
                              title: tr('create_tr'),
                              bgColor: Colors.pink.shade500,
                              textColor: Colors.white,
                              textSize: size.height * AppConstants.btnTextSize,
                              verPadding: size.height * AppConstants.btnVerPadding,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  callSignUpApi(signupPro);
                                }else{
                                  signupPro.phoneNoController.text = signupPro.tempPhoneNoController.text;
                                }
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.02,),
                          Expanded(
                            flex: 1,
                            child: CustomElevationBtn(
                              title: tr('cancel_tr'),
                              bgColor: AppColors.white,
                              textColor: AppColors.appColor,
                              textSize: size.height * AppConstants.btnTextSize,
                              verPadding: size.height * AppConstants.btnVerPadding,
                              btnBorder: true,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }

  DateTime selectedDate = DateTime.now();
  void _selectDate(BuildContext context, SignUpProvider signUpPro) {
    DateTime? today = DateTime.now();
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime(today.year - 18, today.month, today.day),
      firstDate: DateTime(1950),
      lastDate: DateTime(today.year - 18, today.month, today.day),
    ).then((DateTime? value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        DateFormat formatter = DateFormat(dateFormat);
        final String date = formatter.format(_fromDate);
        print('second== '+date);
        selectedDate = _fromDate;
        signUpPro.dobController.text = date;
      }
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    locationWrapper.fullAddress = address;
    locationWrapper.latitude = position.latitude;
    locationWrapper.longitude = position.longitude;
    setState(()  {
    });
  }

  Widget radioButtons(Size size, SignUpProvider signUpProvider){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: _radioValue,
              activeColor: AppColors.appColor,
              onChanged:  _handleRadioValueChange,
            ),
            Text('txt_male_tr', style: TextStyle(fontSize: size.height * 0.020,),).tr()
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: _radioValue,
              activeColor: AppColors.appColor,
              onChanged:  _handleRadioValueChange,
            ),
            Text('txt_female_tr', style: TextStyle(fontSize: size.height * 0.020,),).tr(),
          ],
        ),
      ],
    );
  }
}

