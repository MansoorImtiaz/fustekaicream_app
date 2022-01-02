import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class AppProvider extends ChangeNotifier{

  String _language = 'en';
  String get language => _language;

  void setLanguage(String value){
    _language = value;
    notifyListeners();
  }
}