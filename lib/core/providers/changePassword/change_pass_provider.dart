import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ChangePassProvider extends ChangeNotifier{

  final TextEditingController _registeredPhoneController = TextEditingController();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();

  TextEditingController get registeredPhoneController => _registeredPhoneController;
  TextEditingController get oldPassController => _oldPassController;
  TextEditingController get newPassController => _newPassController;
  TextEditingController get rePassController => _rePassController;


  bool _isOldPassVisible = true;
  bool _isNewPassVisible = true;
  bool _isRePassVisible = true;
  bool get isOldPassVisible => _isOldPassVisible;
  bool get isNewPassVisible => _isNewPassVisible;
  bool get isRePassVisible => _isRePassVisible;

  void setOldPassVisibility(){
    _isOldPassVisible = !_isOldPassVisible;
    notifyListeners();
  }

  void setNewPassVisibility(){
    _isNewPassVisible = !_isNewPassVisible;
    notifyListeners();
  }

  void setRePassVisibility(){
    _isRePassVisible = !_isRePassVisible;
    notifyListeners();
  }


  void clearAllFields(){
    _oldPassController.text = '';
    _newPassController.text = '';
    _rePassController.text = '';
    notifyListeners();
  }
}