import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LocationTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isEmail;
  final TextInputType keyboard;
  final String validationMsg;
  final VoidCallback onTap;

  const LocationTextField({Key? key,
    required this.controller,
    required this.label,
    this.isEmail = false,
    required this.keyboard,
    this.validationMsg = 'field_required_tr',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(validationMsg);
        }
        return null;
      },
      readOnly: true,
      textInputAction: TextInputAction.done,
      keyboardType: keyboard,
      controller: controller,
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
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0),),
          borderSide: BorderSide(color: Colors.black, width: 0.0),
        ),
        hintText: label,
        labelStyle: const TextStyle(
            color: AppColors.black,
            // fontSize: size.height * 0.022,
            fontWeight: FontWeight.normal
        ),
        suffixIcon: IconButton(
          onPressed: () => onTap(),/*{
            Position position = await _getGeoLocationPosition();
            location ='Lat: ${position.latitude} , Long: ${position.longitude}';
            getAddressFromLatLong(position);
            _locationController.text = locationWrapper.fullAddress??"";
          },*/
          icon: Icon(
            Icons.location_pin,
            color: Colors.black.withOpacity(0.5),
            size: size.height * 0.03,
          ),
        ),
      ),
    );
  }

/*  Future<Position> _getGeoLocationPosition() async {
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
  }*/
}
