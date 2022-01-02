import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LoginPhoneOrPassTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final TextInputType keyboard;
  final String validationMsg;

  const LoginPhoneOrPassTextField({Key? key,
    required this.controller,
    required this.label,
    required this.keyboard,
    this.validationMsg = 'field_required_tr'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppFunctions _appFunctions = AppFunctions();
    var loginPro = context.read<LoginProvider>();
    String? userValue = '';
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(validationMsg);
        }else if (value.length < 11) {
          return tr('should_11_digits_tr');
        }else{
          userValue = value;

          if(_appFunctions.isNumeric(userValue!)){
            if(userValue!.startsWith('+')){
              if (userValue!.startsWith('+964')) {
                if(userValue!.length == 14){
                  //true
                  userValue = userValue!.substring(1);
                  loginPro.forAPIEmailOrPassController.text = '00'+userValue!;
                  // loginPro.forAPIEmailOrPassController.text = value;
                }else{
                  //false
                  return tr('enter_valid_no_tr');
                }
              }else{
                //false
                return tr('enter_valid_no_tr');
              }
            }else{
              if(userValue!.length > 9 && userValue!.length < 16){
                //true
                userValue = _appFunctions.getFinalNum(userValue!);
                if(userValue!.isNotEmpty){
                  print(userValue);
                  loginPro.forAPIEmailOrPassController.text = '00964'+userValue!;
                  // loginPro.forAPIEmailOrPassController.text = value;
                  print('Valid = '+_appFunctions.isPhoneValid(userValue!).toString());
                }else{
                  //false
                  return tr('enter_valid_no_tr');
                }
              }else{
                //false
                return tr('enter_valid_no_tr');
              }
            }
          }else{
            //false
            if(!_appFunctions.isEmailValid(userValue!)){
              return tr('enter_valid_email_tr');
            }
          }
        }
        return null;
      },
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
        labelStyle: TextStyle(
            color: AppColors.black.withOpacity(0.75),
            fontSize: size.height * 0.022,
            fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}
