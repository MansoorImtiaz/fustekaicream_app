import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ViewProfileBody extends StatefulWidget {
  const ViewProfileBody({Key? key}) : super(key: key);

  @override
  _ViewProfileBodyState createState() => _ViewProfileBodyState();
}

class _ViewProfileBodyState extends State<ViewProfileBody> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final AppFunctions _appFunctions = AppFunctions();
  final String dateFormat = 'dd-MM-yyyy';
  final SharedPref _sharedPref =  SharedPref();
  LocationWrapper locationWrapper = LocationWrapper();
  AppStorage storage =  AppStorage();
  bool? isEng;
  String location = '';
  String name = '';
  String address = 'search';


  getUserProfileFromDB() async{
    // signupPro = context.read<SignUpProvider>();
    _appFunctions.startLoading();
    await storage.getUserProfile(context);
    // name = signupPro.viewNameUPController.text;
    _appFunctions.loadingDismiss();
  }

  @override
  void initState() {
    super.initState();
    setCurrentLang();
    // getUserProfileFromDB();
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
              child: const Text('my_profile_tr').tr()),
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
                              padding: EdgeInsets.symmetric(vertical: size.height * AppConstants.screenVerPadding, horizontal: size.width * AppConstants.screenHorPadding,),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    /*SizedBox(
                                        width: size.width,
                                        child: Text('my_profile_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading),).tr()),
                                    SizedBox(height: size.height * AppConstants.lonGapBWWidgets,),*/
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          color: Colors.amber,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('first_name_without_star_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewNameUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          color: Colors.lime,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('sur_name_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewSurnameUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color: Colors.cyan,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('email_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewEmailUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range_outlined,
                                          color: Colors.green,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('dob_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewDOBUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_city_outlined,
                                          color: Colors.pink,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('city_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewCityUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.purple,
                                          size: size.height * 0.035,
                                        ),
                                        SizedBox(width: size.width * 0.04,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('location_without_star_tr', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent, color: Colors.grey.shade700,),).tr(),
                                              Text(signupPro.viewLocationUPController.text, style: TextStyle(fontSize: size.height * AppConstants.smallTextSize, color: Colors.grey.shade700,),).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.shade500,
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
                              title: tr('edit_tr'),
                              bgColor: Colors.pink.shade500,
                              textColor: Colors.white,
                              textSize: size.height * 0.03,
                              // verPadding: size.height * 0.010,
                              onTap: () {
                                Navigator.push(context, AppRoutes().editProfileScreen);
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

  setCurrentLang() async{
    isEng = await _sharedPref.getIsEngActive();
    print('isEng=='+isEng.toString());
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
