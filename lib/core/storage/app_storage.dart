import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class AppStorage extends StorageBase{

  static final AppStorage _instance = AppStorage._internal();

  factory AppStorage(){
    return _instance;
  }

  AppStorage._internal(){
    _storage = const FlutterSecureStorage();
  }

  void updateCities(MainCitiesModel? citiesModel, String lang){
    try {
      lang.contains('en')
      ? addNewItem(englishCities, jsonEncode(citiesModel))
      : addNewItem(arabicCities, jsonEncode(citiesModel));
    } catch (e) {
      print(e);
    }
  }

  void updateUserProfile(AppMainModel? appMainModel){
    try {
      addNewItem(userProfile, jsonEncode(appMainModel));
    } catch (e) {
      print(e);
    }
  }

  void updateHomeSlider(MainHomeSliderModel? homeSliderModel){
    try {
      addNewItem(homeSlider, jsonEncode(homeSliderModel));
    } catch (e) {
      print(e);
    }
  }


  Future<void> getUserProfile(BuildContext context) async{
    try {
      var signupPro = context.read<SignUpProvider>();
      List<LocalUserProfileModel> localUserProfileList = [];
      AppMainModel appMainModel = AppMainModel();
      String? uProfile = await readWhereKey(userProfile);
      if(uProfile == null){
            signupPro.setUserProfileList(localUserProfileList);
          }else{
            print('userProfile== '+uProfile);
            appMainModel = AppMainModel.fromJson(json.decode(uProfile));
            localUserProfileList.add(LocalUserProfileModel(
              id: appMainModel.data!.user!.id,
              token: appMainModel.data!.token,
              firstName: appMainModel.data!.user!.firstName,
              surName: appMainModel.data!.user!.surName,
              city: appMainModel.data!.user!.city,
              phone: appMainModel.data!.user!.phone,
              email: appMainModel.data!.user!.email,
              dob: appMainModel.data!.user!.dob,
              location: appMainModel.data!.user!.location,
            ));
            signupPro.setUserProfileList(localUserProfileList);
          }
    } catch (e) {
      print('userProfileError== '+e.toString());
    }
  }

  Future<void> getCities(BuildContext context, String lang) async{
    var signupPro = context.read<SignUpProvider>();
    List<LocalCitiesModel> localCitiesList = [];
    List<Cities> citiesList = [];
    MainCitiesModel mainCitiesModel = MainCitiesModel();
    String? cities = lang.contains('en')
        ? await readWhereKey(englishCities)
        : await readWhereKey(arabicCities);
    if(cities != null){
      print('cities=='+cities);
      mainCitiesModel = MainCitiesModel.fromJson(json.decode(cities));
      if (mainCitiesModel.cities != null) {
        for(var i = 0; i < mainCitiesModel.cities!.length; i++){
          localCitiesList.add(LocalCitiesModel(transId: mainCitiesModel.cities![i].transId, cityName: mainCitiesModel.cities![i].cityName));
        }
        lang.contains('en')
            ? signupPro.setEngCitiesList(localCitiesList)
            : signupPro.setArabicCitiesList(localCitiesList);
      }
    }
  }

  Future<void> getHomeSliderList(BuildContext context) async{
    final AppFunctions _appFunctions = AppFunctions();
    var signupPro = context.read<SignUpProvider>();
    List<LocalHomeSliderModel> localHomeSliderList = [];
    MainHomeSliderModel mainHomeSliderModel = MainHomeSliderModel();
    String? sliders = await readWhereKey(homeSlider);
    if(sliders != null){
      print('sliders== '+sliders);
      mainHomeSliderModel = MainHomeSliderModel.fromJson(json.decode(sliders));
      if (mainHomeSliderModel.homeSlider != null) {
        for(var i = 0; i < mainHomeSliderModel.homeSlider!.length; i++){
          localHomeSliderList.add(LocalHomeSliderModel(id: mainHomeSliderModel.homeSlider![i].id!, image: mainHomeSliderModel.homeSlider![i].image));
        }
        signupPro.setHomeSliderList(localHomeSliderList);
      }
    }
    // _appFunctions.loadingDismiss();
  }

}

abstract class StorageBase{

  @protected
  late FlutterSecureStorage _storage;

  final key_user_name = "user_name";
  final key_user_phone = "user_phone";
  final key_project = "project";
  final key_transaction = "transaction";
  final key_attachments = "attachments";
  final englishCities = "enCities";
  final arabicCities = "arCities";
  final userProfile = "userProfile";
  final homeSlider = "homeSlider";


  void addNewItem(String key, String value) async{
    await _storage.write(key: key, value: value);
    print("fff" +_storage.toString());
  }

  Future<String?> readWhereKey(String key) async{
    final keyValue = await _storage.read(key: key);
    return keyValue;
  }
}