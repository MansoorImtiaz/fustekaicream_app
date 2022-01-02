import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class SignUpProvider extends ChangeNotifier{

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _tempPhoneNoController = TextEditingController();
  final TextEditingController _forFirebasePhoneController = TextEditingController();
  final TextEditingController _forAPIPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _viewNameUPController = TextEditingController();
  final TextEditingController _viewSurnameUPController = TextEditingController();
  final TextEditingController _viewCityUPController = TextEditingController();
  final TextEditingController _viewPhoneUPController = TextEditingController();
  final TextEditingController _viewEmailUPController = TextEditingController();
  final TextEditingController _viewDOBUPController = TextEditingController();
  final TextEditingController _viewLocationUPController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get surnameController => _surnameController;
  TextEditingController get cityController => _cityController;
  TextEditingController get phoneNoController => _phoneNoController;
  TextEditingController get tempPhoneNoController => _tempPhoneNoController;
  TextEditingController get forFirebasePhoneController => _forFirebasePhoneController;
  TextEditingController get forAPIPhoneController => _forAPIPhoneController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passController => _passController;
  TextEditingController get rePassController => _rePassController;
  TextEditingController get dobController => _dobController;
  TextEditingController get genderController => _genderController;
  TextEditingController get locationController => _locationController;

  TextEditingController get viewNameUPController => _viewNameUPController;
  TextEditingController get viewSurnameUPController => _viewSurnameUPController;
  TextEditingController get viewCityUPController => _viewCityUPController;
  TextEditingController get viewPhoneUPController => _viewPhoneUPController;
  TextEditingController get viewEmailUPController => _viewEmailUPController;
  TextEditingController get viewDOBUPController => _viewDOBUPController;
  TextEditingController get viewLocationUPController => _viewLocationUPController;


  bool _isPassVisible = true;
  bool _isRePassVisible = true;
  List<LocalUserProfileModel> _userProfileList = [];
  List<LocalHomeSliderModel> _homeSliderList = [];
  List<LocalCitiesModel> _engCitiesList = [];
  List<LocalCitiesModel> _arabicCitiesList = [];
  bool get isPassVisible => _isPassVisible;
  bool get isRePassVisible => _isRePassVisible;
  List<LocalUserProfileModel> get userProfileList => _userProfileList;
  List<LocalHomeSliderModel> get homeSliderList => _homeSliderList;
  List<LocalCitiesModel> get engCitiesList => _engCitiesList;
  List<LocalCitiesModel> get arabicCitiesList => _arabicCitiesList;

  void setPassVisibility(){
    _isPassVisible = !_isPassVisible;
    notifyListeners();
  }

  void setRePassVisibility(){
    _isRePassVisible = !_isRePassVisible;
    notifyListeners();
  }

  void setUserProfileList(List<LocalUserProfileModel> localUserProfileList){
    _userProfileList = List.from(localUserProfileList);
    _viewNameUPController.text = _userProfileList[0].firstName ?? '';
    _viewSurnameUPController.text = _userProfileList[0].surName ?? '';
    _viewCityUPController.text = _userProfileList[0].city ?? '';
    _viewPhoneUPController.text = _userProfileList[0].phone ?? '';
    _viewEmailUPController.text = _userProfileList[0].email ?? '';
    _viewDOBUPController.text = _userProfileList[0].dob ?? '';
    _viewLocationUPController.text = _userProfileList[0].location ?? '';
    notifyListeners();
  }

  void setHomeSliderList(List<LocalHomeSliderModel> list){
    _homeSliderList = List.from(list);
    notifyListeners();
  }

  void setEngCitiesList(List<LocalCitiesModel> list){
    _engCitiesList = List.from(list);
    notifyListeners();
  }

  void setArabicCitiesList(List<LocalCitiesModel> list){
    _arabicCitiesList = List.from(list);
    notifyListeners();
  }

  bool _isAccepted = false;
  bool get isAccepted => _isAccepted;

  void setAccepted(bool value){
    _isAccepted = value;
    notifyListeners();
  }

  void clearAllFields(){
    nameController.text = '';
    surnameController.text = '';
    cityController.text = '';
    forAPIPhoneController.text = '';
    // phoneNoController.text = '';
    // emailController.text = '';
    passController.text = '';
    rePassController.text = '';
    dobController.text = '';
    genderController.text = '';
    locationController.text = '';
    notifyListeners();
  }
}