import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:intl/intl.dart';

class OldSignUpBody extends StatefulWidget {
  const OldSignUpBody({Key? key}) : super(key: key);

  @override
  _OldSignUpBodyState createState() => _OldSignUpBodyState();
}

class _OldSignUpBodyState extends State<OldSignUpBody> {

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String surname = '';
  String city = '';
  String phone = '';
  String email = '';
  String dob = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final String dateFormat = 'DD-MM-YYYY';
  int? _radioValue = 0;
  String location ='Null, Press Button';
  String address = 'search';
  LocationWrapper locationWrapper = LocationWrapper();

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              width: size.width,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.04,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFieldWithoutLabelBorder(
                        controller: _nameController,
                        validationMsg: 'field required!',
                        icon: Icons.person,
                        label: 'Name',
                        keyboard: TextInputType.text,
                      ),
                      SizedBox(height: size.height * 0.01,),
                      CustomFieldWithoutLabelBorder(
                        controller: _surnameController,
                        validationMsg: 'field required!',
                        icon: Icons.person,
                        label: 'Surname',
                        keyboard: TextInputType.text,
                      ),
                      SizedBox(height: size.height * 0.01),
                      CustomFieldWithoutLabelBorder(
                        controller: _cityController,
                        validationMsg: 'field required!',
                        icon: Icons.location_pin,
                        label: 'City',
                        keyboard: TextInputType.text,
                      ),
                      SizedBox(height: size.height * 0.01,),
                      CustomFieldWithoutLabelBorder(
                        controller: _phoneController,
                        validationMsg: 'field required!',
                        icon: Icons.phone,
                        label: 'Phone',
                        keyboard: TextInputType.phone,
                      ),
                      SizedBox(height: size.height * 0.01,),
                      CustomFieldWithoutLabelBorder(
                        controller: _emailController,
                        validationMsg: 'field required!',
                        icon: Icons.email,
                        label: 'Email',
                        keyboard: TextInputType.emailAddress,
                      ),
                      SizedBox(height: size.height * 0.01,),
                      InkWell(
                        onTap: () {
                          _selectDate();   // Call Function that has showDatePicker()
                        },
                        child: IgnorePointer(
                          child: _fieldGetDOB(size),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01,),
                      _fieldGetLocation(size),
                      SizedBox(height: size.height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged:  _handleRadioValueChange,
                              ),
                              Text('Male', style: TextStyle(fontSize: size.height * 0.020,),)
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged:  _handleRadioValueChange,
                              ),
                              Text('Female', style: TextStyle(fontSize: size.height * 0.020,),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01,),
                      CustomMaterialButton(
                          title: 'Sign Up',
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                name = _nameController.text;
                                surname = _surnameController.text;
                                city = _cityController.text;
                                phone = _phoneController.text;
                                email = _emailController.text;
                                dob = _dobController.text;
                              });
                            }
                          }
                      ),
                      SizedBox(height: size.height * 0.020),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    ).then((DateTime? value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        DateFormat formatter = DateFormat(dateFormat);
        final String date = formatter.format(_fromDate);
        _dobController.text = date;
      }
    });
  }

  Widget _fieldGetDOB(Size size){
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field required!';
          }
          return null;
        },
        controller: _dobController,
        textInputAction: TextInputAction.done,
        style: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.020
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: size.height * 0.020,
              fontWeight: FontWeight.normal
          ),
          labelText: 'Date of birth',
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black.withOpacity(0.5),
            size: size.height * 0.03,
          ),
        )
    );
  }

  Widget _fieldGetLocation(Size size){
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field required!';
          }
          return null;
        },
        controller: _locationController,
        textInputAction: TextInputAction.done,
        style: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.020
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: size.height * 0.020,
              fontWeight: FontWeight.normal
          ),
          labelText: 'Location',
          prefixIcon: Icon(
            Icons.map,
            color: Colors.black.withOpacity(0.5),
            size: size.height * 0.03,
          ),
          suffixIcon: IconButton(
            onPressed: () async{
              Position position = await _getGeoLocationPosition();
              location ='Lat: ${position.latitude} , Long: ${position.longitude}';
              getAddressFromLatLong(position);
              _locationController.text = locationWrapper.fullAddress??"";
            },
            icon: Icon(
              Icons.location_pin,
              color: Colors.black.withOpacity(0.5),
              size: size.height * 0.03,
            ),
          ),
        )
    );
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
