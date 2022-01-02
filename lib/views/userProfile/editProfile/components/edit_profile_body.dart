import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({Key? key}) : super(key: key);

  @override
  _EditProfileBodyState createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final String dateFormat = 'dd-MM-yyyy';
  final SharedPref _sharedPref =  SharedPref();
  LocationWrapper locationWrapper = LocationWrapper();
  final AppFunctions _appFunctions = AppFunctions();
  AppStorage storage =  AppStorage();
  final service = ApiServices();
  bool? isEng;
  String? userId = '';
  String location = '';
  String address = 'search';

  getUserProfileFromDB() async{
    var signUpPro = context.read<SignUpProvider>();
    _appFunctions.startLoading();
    await storage.getUserProfile(context);

    if(signUpPro.engCitiesList.isEmpty){
      await storage.getCities(context, 'en');
    }
    if(signUpPro.arabicCitiesList.isEmpty){
      await storage.getCities(context, 'ar');
    }
    _appFunctions.loadingDismiss();
  }


  callEditProfileApi(SignUpProvider signUpPro){
    _appFunctions.startLoading();
    final service = ApiServices();
    service.apiEditProfile(context, userId).then((value){
      if(value.success == true){
        signUpPro.clearAllFields();
        print('Success ================');
        _appFunctions.loadingDismiss();
        _appFunctions.successMsg(('update_success_msg_tr').tr());
        Navigator.pop(context);
        Navigator.pop(context);
      }else{
          print('data not found!');
          _appFunctions.loadingDismiss();
          _appFunctions.errorMsg(('signup_error_msg_tr').tr());

      }
    });
  }

  @override
  void initState() {
    getPrefData();
    getUserProfileFromDB();
    super.initState();
  }

  @override
  void dispose() {
    _appFunctions.loadingDismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signupPro = context.read<SignUpProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true, //for add/remove back arrow
        title: Center(
          child: const Text('edit_profile_tr').tr()),
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
                            padding: EdgeInsets.fromLTRB(size.width * 0.06, size.width * 0.12, size.width * 0.06, size.width * 0.03),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Text('first_name_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  AppSimpleTextField(
                                    controller: signupPro.viewNameUPController,
                                    keyboard: TextInputType.text,
                                    hintText: tr('hint_name_tr'),
                                    isName: true,
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('sur_name_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  OptionalTextField(
                                    controller: signupPro.viewSurnameUPController,
                                    keyboard: TextInputType.text,
                                    label: tr('hint_surname_tr'),
                                    isSurname: true,
                                  ),
                                  /*SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('phone_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  PhoneTextField(
                                    controller: signupPro.viewPhoneUPController,
                                    keyboard: TextInputType.number,
                                    label: tr('hint_phone_tr'),
                                    isEdit: true,
                                  ),*/
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('email_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  OptionalTextField(
                                      controller: signupPro.viewEmailUPController,
                                      label: tr('hint_email_tr'),
                                      keyboard: TextInputType.emailAddress,
                                      isEmail: true
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('dob_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context,signupPro);   // Call Function that has showDatePicker()
                                    },
                                    child: IgnorePointer(
                                      child: OptionalTextField(
                                        controller: signupPro.viewDOBUPController,
                                        keyboard: TextInputType.text,
                                        label: tr('hint_dob_tr'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('city_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
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
                                        controller: signupPro.viewCityUPController,
                                        keyboard: TextInputType.text,
                                        hintText: tr('hint_city_tr'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03,),
                                  SizedBox(
                                      width: size.width,
                                      child: Text('location_tr', style: TextStyle(fontSize: size.height * 0.025),).tr()
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  LocationTextField(
                                    controller: signupPro.viewLocationUPController,
                                    keyboard: TextInputType.text,
                                    label: tr('hint_location_tr'),
                                    onTap: () async {
                                      Position position = await _getGeoLocationPosition();
                                      location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                                      getAddressFromLatLong(position);
                                      signupPro.viewLocationUPController.text = locationWrapper.fullAddress??"";
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
                            title: tr('submit_tr'),
                            bgColor: Colors.pink.shade500,
                            textColor: Colors.white,
                            textSize: size.height * 0.03,
                            // verPadding: size.height * 0.010,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                callEditProfileApi(signupPro);
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
                            textSize: size.height * 0.03,
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

  getPrefData() async{
    isEng = await _sharedPref.getIsEngActive();
    userId = await _sharedPref.getUserId();
    print('isEng=='+isEng.toString());
    print('userId=='+userId.toString());
  }

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
        signUpPro.viewDOBUPController.text = date;
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
}

