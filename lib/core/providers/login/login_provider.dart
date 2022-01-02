import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LoginProvider extends ChangeNotifier{

  final TextEditingController _forAPIEmailOrPassController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  TextEditingController get forAPIEmailOrPassController => _forAPIEmailOrPassController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passController => _passController;

  bool _isPassVisible = true;
  bool get isPassVisible => _isPassVisible;

  void setPassVisibility(){
    _isPassVisible = !_isPassVisible;
    notifyListeners();
  }

  void clearAllFields(){
    forAPIEmailOrPassController.text = '';
    emailController.text = '';
    passController.text = '';
    notifyListeners();
  }
}