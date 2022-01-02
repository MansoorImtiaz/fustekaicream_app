import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';


class AppFunctions{

  final SharedPref _sharedPref =  SharedPref();
  int currentCircle = 0;

  void customSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            content: Text(msg, style: const TextStyle(fontSize: 18.0, color: AppColors.black),).tr()
        )
    );
  }

  void showToast(String msg){
    Fluttertoast.showToast(
        msg: tr(msg),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void customizeLoadings(Color bg, Color fg){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = bg
      ..indicatorColor = fg
      ..textColor = fg
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true;
  }

  void errorMsg(String error){
    customizeLoadings(AppColors.error, AppColors.white);
    EasyLoading.showError(error);
  }

  void successMsg(String success){
    customizeLoadings(AppColors.success, AppColors.white);
    EasyLoading.showSuccess(success);
  }

  void loadingDismiss(){
    EasyLoading.dismiss();
  }

  void startLoading(){
    customizeLoadings(AppColors.appColor, AppColors.white);
    EasyLoading.show(status: tr('loading_tr'));
  }

  void infoMsg(String message){
    customizeLoadings(AppColors.warning, AppColors.white);
    EasyLoading.showInfo(message);
    // EasyLoading.show(status: 'Check your internet connectivity',indicator: const Icon(Icons.wifi, color: Colors.white, size: 25,));
  }

  void noInternetMsg(String message){
    customizeLoadings(AppColors.error, AppColors.white);
    EasyLoading.showInfo(message);
    // EasyLoading.show(status: 'Check your internet connectivity',indicator: const Icon(Icons.wifi, color: Colors.white, size: 25,));
  }

  String getCardCircle(){
    String circle = '';
    switch(currentCircle){
      case 0:
        circle = AppAssets.circleYellow;
        currentCircle = 1;
        break;
      case 1:
        circle = AppAssets.circleOrange;
        currentCircle = 2;
        break;
      case 2:
        circle = AppAssets.circleRed;
        currentCircle = 3;
        break;
      case 3:
        circle = AppAssets.circlePink;
        currentCircle = 4;
        break;
      case 4:
        circle = AppAssets.circleDarkPurple;
        currentCircle = 5;
        break;
      case 5:
        circle = AppAssets.circleLightPurple;
        currentCircle = 0;
        break;
    }
    return circle;
  }

  String? setFinalNum(String num) {
    String? finalNum = '';
    if(num.length == 15){
      finalNum = num.substring(5);
    }else if(num.length == 14){
      finalNum = num.substring(4);
    }else if(num.length == 13){
      finalNum = num.substring(3);
    }else if(num.length == 12){
      finalNum = num.substring(2);
    }else if(num.length == 11){
      finalNum = num.substring(1);
    }else{
      finalNum = num;
    }
    return finalNum;
  }


  String? getFinalNum(String num) {
    String? finalNum = '';
    if(num.length == 15){
      if (num.startsWith('00964')) {
        finalNum = num.substring(5);
      }else{
        finalNum = '';
      }
    }else if(num.length == 14){
      if (num.startsWith('0964')) {
        finalNum = num.substring(4);
      }else{
        finalNum = '';
      }
    }else if(num.length == 13){
      if (num.startsWith('964')) {
        finalNum = num.substring(3);
      }else{
        finalNum = '';
      }
    }else if(num.length == 12){
      if(num.contains('00000000000')){
        finalNum = '';
      }else{

        if (num.startsWith('00')) {
          finalNum = num.substring(2);
        }else{
          finalNum = '';
        }
      }
    }else if(num.length == 11){
      if(num.contains('00000000000')){
        finalNum = '';
      }else{

        if (num.startsWith('0')) {
          finalNum = num.substring(1);
        }else{
          finalNum = '';
        }
      }
    }else if(num.length == 10){
      if(num.contains('0000000000')){
        finalNum = '';
      }else{
        finalNum = num;
      }
    }else{
      finalNum = '';
    }
    return finalNum;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Color getHexColor(String hashColor) {
    String withoutHash = hashColor.substring(1);
    String hexColor = '0xff$withoutHash';
    int? finalHexColor = int.parse(hexColor);
    return Color(finalHexColor);
  }

  bool isEmailValid(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return emailValid;
  }

  bool isPhoneValid(String value) {
    bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
    return phoneValid;
  }
}