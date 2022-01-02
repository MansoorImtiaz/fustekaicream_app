import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  final String mainUrl = 'https://fustekagroupdev.com/api/';
  final String loginUrl = 'login';
  final String signUpUrl = 'register';
  final String signOutUrl = 'logout';
  final String citiesUrl = 'cities?lang_name=';
  final String phoneVerifyUrl = 'save/user/status';
  final String categoriesUrl = 'categories?lang_name=';
  final String subCategoriesUrl = 'get/subcategories';
  final String subProductsUrl = 'get/products';
  final String singleProductsUrl = 'single/product';
  final String allProductsUrl = 'products?lang_name=';
  final String offeredProducts  = 'get-offer-products/';
  final String campaignUrl = 'campaign';
  final String updateProfile = 'profile/update/';
  final String changePass = 'change-password/';
  final String forgotPass = 'forgot-password';
  final String homeSlider = 'get-sliders';
  final String allMekanosImages = 'get-mekanos/';
  final String winnerMekanos = 'get-winning-mekanos/';
  final String winnerLotteries = 'get-lotteries/';
  final String winnerInstantGifts  = 'get-gifts/';
  final String mekanoGallery  = 'get-mekanos-winners?page=';
  final String isValidNo  = 'is-active-user';

  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  final Dio _dio = Dio();


  Future<AppMainModel?> apiLogin(String emailOrPass, String pass) async{
    try {
      AppMainModel loginModel = AppMainModel();
      AppStorage storage =  AppStorage();
      var url = Uri.parse('$mainUrl$loginUrl');
      var response = await http.post(
        url,
        body: <String, String>{
            "email": emailOrPass,
            "password": pass
        });
      if (response.statusCode == 200) {
              print("RESPONSE=" + response.body);
              loginModel = AppMainModel.fromJson(json.decode(response.body));
              storage.updateUserProfile(loginModel);
              return AppMainModel.fromJson(json.decode(response.body));
          }else{
            return AppMainModel.fromJson(json.decode(response.body));
          }
    } catch (e) {
      _appFunctions.loadingDismiss();
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }

  Future<AppMainModel?> apiPhoneVerify(Map<String,dynamic> param) async{
    try {
      AppMainModel loginModel = AppMainModel();
      var url = Uri.parse('$mainUrl$phoneVerifyUrl');
      var response = await http.post(url, body: param);
      if (response.statusCode == 200) {
              print("RESPONSE=" + response.body);
              loginModel = AppMainModel.fromJson(json.decode(response.body));
              return loginModel;
          }else{
            return AppMainModel.fromJson(json.decode(response.body));
          }
    } catch (e) {
      _appFunctions.loadingDismiss();
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }

  Future<void> apiUploadCampaignImage(BuildContext context, int sticksNo, File imageFile) async{
    try {
      String? userId = await _sharedPref.getUserId();
      var url = Uri.parse('$mainUrl$campaignUrl');
      var request = http.MultipartRequest("POST", url);
      request.fields['no_sticks'] = sticksNo.toString();
      request.fields['user_id'] = userId.toString();
      request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path
      ));
      /*request.files.add(await http.MultipartFile.fromPath(
    'package', 'build/package.tar.gz',
    contentType: MediaType('application', 'x-tar')));*/
      /*var response = await http.post(
              url,
              body: <String, dynamic>{
                  "no_sticks": sticksNo.toString(),
                  "user_id": userId.toString(),
                  "image": MultipartFile.fromFile(imageFile.path)
              }
          );*/
      request.send().then((response) {
        if (response.statusCode == 200) {
          print("RESPONSE=" + response.toString());
          print('Success ================');
          _appFunctions.loadingDismiss();
          _appFunctions.successMsg(('submitted_success_image_tr').tr());
          Navigator.pop(context);
        }else{
          print('data not found!');
          _appFunctions.loadingDismiss();
          _appFunctions.errorMsg(('error').tr());
        }
      });
    } catch (e) {
      print('error== '+e.toString());
    }
  }

  Future<AppMainModel> apiSignUp1(BuildContext context) async{
    var signUpPro = context.read<SignUpProvider>();
    AppMainModel loginModel = AppMainModel();
    var url = Uri.parse('$mainUrl$signUpUrl');
    var response = await http.post(
        url,
        body: <String, String>{
            "email": signUpPro.emailController.text,
            "password": signUpPro.passController.text,
            "confirm_password": signUpPro.rePassController.text,
            "first_name": signUpPro.nameController.text,
            "sur_name": signUpPro.surnameController.text,
            "dob": signUpPro.dobController.text,
            "phone": signUpPro.forAPIPhoneController.text,
            "gender": signUpPro.genderController.text,
             "city": signUpPro.cityController.text,
            "location": signUpPro.locationController.text,
            "country": 'Iraq',
             "country_code": '964',
        }
    );
    // print("RESPONSE=" + response.body);
    if (response.statusCode == 200) {
        print("RESPONSE SignUp=" + response.body);
        loginModel = AppMainModel.fromJson(json.decode(response.body));
        return loginModel;
    }else{
      return AppMainModel.fromJson(json.decode(response.body));
    }
  }

  Future<AppMainModel> apiEditProfile(BuildContext context, String? userId) async{
    var signUpPro = context.read<SignUpProvider>();
    AppStorage storage =  AppStorage();
    AppMainModel loginModel = AppMainModel();
    var url = Uri.parse('$mainUrl$updateProfile$userId');
    print("update profile URL = "  '$url');
    var response = await http.post(
        url,
        body: <String, String>{
            "first_name": signUpPro.viewNameUPController.text,
            "sur_name": signUpPro.viewSurnameUPController.text,
            "email": signUpPro.viewEmailUPController.text,
            "dob": signUpPro.viewDOBUPController.text,
            "location": signUpPro.viewLocationUPController.text,
            "city": signUpPro.viewCityUPController.text,
        }
    );
    if (response.statusCode == 200) {
        print("RESPONSE= " + response.body);
        print("Phone= " + signUpPro.viewPhoneUPController.text);
        loginModel = AppMainModel.fromJson(json.decode(response.body));
        storage.updateUserProfile(loginModel);
        return loginModel;
    }else{
      return AppMainModel.fromJson(json.decode(response.body));
    }
  }

  Future<ChangePassword> apiChangePass(BuildContext context, String? userId) async{
    var changePassPro = context.read<ChangePassProvider>();
    ChangePassword changePassword = ChangePassword();
    var url = Uri.parse('$mainUrl$changePass$userId');
    print("update profile URL = "  '$url');
    var response = await http.post(
        url,
        body: <String, String>{
            "old_password": changePassPro.oldPassController.text,
            "new_password": changePassPro.newPassController.text,
            "confirm_password": changePassPro.rePassController.text,
        }
    );
    if (response.statusCode == 200) {
        print("RESPONSE= " + response.body);
        changePassword = ChangePassword.fromJson(json.decode(response.body));
        return changePassword;
    }else{
      return ChangePassword.fromJson(json.decode(response.body));
    }
  }

  Future<ChangePassword> apiForgotPass(BuildContext context) async{
    var changePassPro = context.read<ChangePassProvider>();
    var signupPro = context.read<SignUpProvider>();
    ChangePassword changePassword = ChangePassword();
    var url = Uri.parse('$mainUrl$forgotPass');
    print("update profile URL = "  '$url');
    var response = await http.post(
        url,
        body: <String, String>{
            "phone": signupPro.forAPIPhoneController.text,
            "password": changePassPro.newPassController.text,
        }
    );
    if (response.statusCode == 200) {
        print("RESPONSE= " + response.body);
        changePassword = ChangePassword.fromJson(json.decode(response.body));
        return changePassword;
    }else{
      return ChangePassword.fromJson(json.decode(response.body));
    }
  }

  Future<IsValidNumber> apiIsValidNumber(BuildContext context, SignUpProvider signUpPro) async{
    IsValidNumber isValidNumber = IsValidNumber();
    var url = Uri.parse('$mainUrl$isValidNo');
    print("update profile URL = "  '$url');
    var response = await http.post(
        url,
        body: <String, String>{
            "phone": signUpPro.forAPIPhoneController.text,
        }
    );
    if (response.statusCode == 200) {
        print("RESPONSE IsValidNumber = " + response.body);
        isValidNumber = IsValidNumber.fromJson(json.decode(response.body));
        return isValidNumber;
    }else{
      return IsValidNumber.fromJson(json.decode(response.body));
    }
  }

  Future<AppMainModel> apiSignUp(Map<String,String> param) async{
    AppMainModel loginModel = AppMainModel();
    var url = Uri.parse('$mainUrl$signUpUrl');
    var response = await http.post(url, headers: param);
    if (response.statusCode == 200) {
        print("RESPONSE=" + response.body);
        loginModel = AppMainModel.fromJson(json.decode(response.body));
        return loginModel;
    }else{
      return AppMainModel.fromJson(json.decode(response.body));
    }
  }

  Future<bool> apiSignOut(Map<String,String> headers) async{
    bool isStatus = false;
    var url = Uri.parse('$mainUrl$signOutUrl');
    var response = await http.post(url, body: headers);
    if (response.statusCode == 200) {
        print("RESPONSE=" + response.body);
        isStatus = true;
        return isStatus;
    }else{
      return isStatus;
    }
  }

  //Not Used
  Future<List<Cities>?> fetchCitiesAPI1() async{
    try{
      Response response = await _dio.get('$mainUrl$citiesUrl');
      List<Cities> cities = Cities.fromJson(response.data) as List<Cities>;
      return cities;
    }on DioError catch(e){
      _appFunctions.errorMsg((e.message).tr());
    }
  }

  Future<void> fetchCitiesAPI(BuildContext context, String lang) async{
    try {
      AppStorage storage =  AppStorage();
      MainCitiesModel mainCitiesModel = MainCitiesModel();
      // Response response = await _dio.get(categoriesUrl);
      var url = Uri.parse('$mainUrl$citiesUrl$lang');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE111=" + response.body);
        mainCitiesModel = MainCitiesModel.fromJson(json.decode(response.body));
        storage.updateCities(mainCitiesModel, lang);
      } else {
        storage.updateCities(mainCitiesModel, lang);
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }

  Future<void> fetchHomeSliderAPI(BuildContext context) async{
    try {
      _appFunctions.startLoading();
      AppStorage storage =  AppStorage();
      MainHomeSliderModel homeSliderModel = MainHomeSliderModel();
      var url = Uri.parse('$mainUrl$homeSlider');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE HomeSlider== " + response.body);
        homeSliderModel = MainHomeSliderModel.fromJson(json.decode(response.body));
        storage.updateHomeSlider(homeSliderModel);
      } else {
        storage.updateHomeSlider(homeSliderModel);
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }

  Future<List<WinnerMekano>?> fetchAllMekanosImagesAPI(BuildContext context, String userId) async{
    try {
      MainWinnerMekanoModel mainWinnerMekanoModel = MainWinnerMekanoModel();
      var url = Uri.parse('$mainUrl$allMekanosImages$userId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE WinnerMekano== " + response.body);
        mainWinnerMekanoModel = MainWinnerMekanoModel.fromJson(json.decode(response.body));
        return mainWinnerMekanoModel.winnerMekano??[];
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
    _appFunctions.loadingDismiss();
  }

  Future<List<WinnerMekano>?> fetchWinnerMekanosAPI(BuildContext context, String userId) async{
    try {
      MainWinnerMekanoModel mainWinnerMekanoModel = MainWinnerMekanoModel();
      var url = Uri.parse('$mainUrl$winnerMekanos$userId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE WinnerMekano== " + response.body);
        mainWinnerMekanoModel = MainWinnerMekanoModel.fromJson(json.decode(response.body));
        return mainWinnerMekanoModel.winnerMekano??[];
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
    _appFunctions.loadingDismiss();
  }

  Future<List<LotteriesOrInstant>?> fetchWinnerLotteriesAPI(BuildContext context, String userId) async{
    try {
      // List<LotteriesOrInstant> lotteriesOrInstantList = [];
      MainWinnerLotteriesAndInstantModel lotteriesAndInstantModel = MainWinnerLotteriesAndInstantModel();
      var url = Uri.parse('$mainUrl$winnerLotteries$userId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE WinnerLotteries== " + response.body);
        lotteriesAndInstantModel = MainWinnerLotteriesAndInstantModel.fromJson(json.decode(response.body));
        return lotteriesAndInstantModel.lotteriesOrInstant;
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
    _appFunctions.loadingDismiss();
  }

  Future<List<LotteriesOrInstant>?> fetchWinnerInstantGiftAPI(BuildContext context, String userId) async{
    try {
      // List<LotteriesOrInstant> lotteriesOrInstantList = [];
      MainWinnerLotteriesAndInstantModel lotteriesAndInstantModel = MainWinnerLotteriesAndInstantModel();
      var url = Uri.parse('$mainUrl$winnerInstantGifts$userId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE WinnerInstantGift== " + response.body);
        lotteriesAndInstantModel = MainWinnerLotteriesAndInstantModel.fromJson(json.decode(response.body));
        return lotteriesAndInstantModel.lotteriesOrInstant??[];
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
    _appFunctions.loadingDismiss();
  }

  Future<MainMekanoGalleryModel?> fetchMekanoGalleryAPI(int currentPage) async{
    try {
      MainMekanoGalleryModel mainMekanoGalleryModel = MainMekanoGalleryModel();
      var url = Uri.parse('$mainUrl$mekanoGallery$currentPage');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE WinnerInstantGift== " + response.body);
        mainMekanoGalleryModel = MainMekanoGalleryModel.fromJson(json.decode(response.body));
        return mainMekanoGalleryModel;
      }
    } catch (e) {
      _appFunctions.errorMsg((e.toString()).tr());
    }
    // _appFunctions.loadingDismiss();
  }

  Future<List<Categories>?> fetchCategoriesAPI() async{
    try {
      String? lang = await _sharedPref.getLang();
      List<Categories> categoriesList = [];
      CategoriesModel categoriesModel = CategoriesModel();
      // Response response = await _dio.get(categoriesUrl);
      var url = Uri.parse('$mainUrl$categoriesUrl$lang');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE111=" + response.body);
        categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
        return categoriesModel.categories;
      } else {
        return categoriesList;
      }
    } catch (e) {
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<List<SubCategories?>?> fetchSubCategoriesAPI(String catId) async{
    try {
      String? lang = await _sharedPref.getLang();
      List<SubCategories> subCategoriesList = [];
      SubCategoriesModel subcategoriesModel = SubCategoriesModel();
      var url = Uri.parse('$mainUrl$subCategoriesUrl');
      var response = await http.post(
          url,
          body: <String, String>{
            'lang_name': lang!,
            'trans_id': catId.toString(),
          }
      );
      if (response.statusCode == 200) {
        print("RESPONSE000=" + response.body);
        subcategoriesModel = SubCategoriesModel.fromJson(json.decode(response.body));
        if(subcategoriesModel.success == true){
          subCategoriesList = List.from(subcategoriesModel.subCategories!);
          return subCategoriesList;
        }
      } else {
        return subCategoriesList;
      }
    } catch (e) {
      print('this error== '+e.toString());
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<List<AllProducts>?> fetchAllProductsAPI() async{
    try {
      String? lang = await _sharedPref.getLang();
      MainAllProducts mainAllProducts = MainAllProducts();
      var url = Uri.parse('$mainUrl$allProductsUrl$lang');
      print("all products URL = "  '$url');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE000=" + response.body);
        mainAllProducts = MainAllProducts.fromJson(json.decode(response.body));
        if(mainAllProducts.success == true){
          return mainAllProducts.allproducts;
        }
      } else {
        return mainAllProducts.allproducts;
      }
    } catch (e) {
      print('this error== '+e.toString());
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<List<AllProducts>?> fetchOfferedProductsAPI() async{
    try {
      String? lang = await _sharedPref.getLang();
      MainAllProducts mainAllProducts = MainAllProducts();
      var url = Uri.parse('$mainUrl$offeredProducts$lang');
      print("all products URL = "  '$url');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE000=" + response.body);
        mainAllProducts = MainAllProducts.fromJson(json.decode(response.body));
        if(mainAllProducts.success == true){
          return mainAllProducts.allproducts;
        }
      } else {
        return mainAllProducts.allproducts;
      }
    } catch (e) {
      print('this error== '+e.toString());
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<SingleProduct?> fetchSingleProductAPI(String productId) async{
    try {
      String? lang = await _sharedPref.getLang();
      MainSingleProduct mainSingleProductModel = MainSingleProduct();
      var url = Uri.parse('$mainUrl$singleProductsUrl');
      print("single product URL = "  '$url');
      var response = await http.post(
          url,
          body: <String, String>{
            'lang_name': lang!,
            'trans_id': productId.toString(),
          }
      );
      if (response.statusCode == 200) {
        print("RESPONSE000=" + response.body);
        mainSingleProductModel = MainSingleProduct.fromJson(json.decode(response.body));
        if(mainSingleProductModel.success == true){
          return mainSingleProductModel.singleProduct;
        }
      } else {
        return mainSingleProductModel.singleProduct;
      }
    } catch (e) {
      print('this error== '+e.toString());
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<List<AllProducts?>?> fetchSubCategoryProducts(String? proId) async{
    String? lang = await _sharedPref.getLang();
    try {
      List<AllProducts> productsList = [];
      MainAllProducts productsListModel = MainAllProducts();
      var url = Uri.parse('$mainUrl$subProductsUrl');
      var response = await http.post(
          url,
          body: <String, String>{
            'lang_name': lang!,
            'trans_id': proId.toString(),
          }
      );
      if (response.statusCode == 200) {
        print("RESPONSE Products=" + response.body);
        productsListModel = MainAllProducts.fromJson(json.decode(response.body));
        if(productsListModel.success == true){
          productsList = List.from(productsListModel.allproducts!);
          // subCategoriesList = subcategoriesModel.subCategories!.map((e) => SubCategories()).toList();
          return productsList;
        }
      } else {
        return productsList;
      }
    } catch (e) {
      print('this error== '+e.toString());
      _appFunctions.errorMsg(('server_error_msg_tr').tr());
    }
  }

  Future<CategoriesModel?> fetchCategoriesAPI1() async{
    try{
      CategoriesModel categoriesModel = CategoriesModel();
      // Response response = await _dio.get(categoriesUrl);
      var url = Uri.parse(categoriesUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE111=" + response.body);
        categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
        return categoriesModel;
      }else{
        return categoriesModel;
      }
    }catch(e){
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }


  Future<CategoriesModel?> apiCategories() async{
    try {
      CategoriesModel categoriesModel = CategoriesModel();
      var url = Uri.parse(categoriesUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("RESPONSE=" + response.body);
        categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
        return categoriesModel;
      }else{
        return CategoriesModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      _appFunctions.loadingDismiss();
      _appFunctions.errorMsg((e.toString()).tr());
    }
  }

  Future<CategoriesModel> fetchCategories() async {
    CategoriesModel categoriesModel = CategoriesModel();
    var url = Uri.parse(categoriesUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
      return categoriesModel;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

/*  Future<List<Cities>> fetchCitiesAPI() async{
    var url = Uri.parse(citiesUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("RESPONSE=" + response.body);
      final json = jsonDecode(response.body) as List<dynamic>;
      final listResult = json.map((e) => Cities.fromJson(e)).toList();
      return listResult;
    }else{
      throw Exception("Error fetching cities");
    }
  }*/

  /*Future<List<PicSumModel>> fetchPictureAPI() async{
    String uri = 'https://picsum.photos/v2/list';
    final response = await http.get(Uri.parse(uri));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List<dynamic>;
      final listResult = json.map((e) => PicSumModel.fromJson(e)).toList();
      return listResult;
    }
    else
      throw Exception("Error fetching Pictures");
  }*/
}