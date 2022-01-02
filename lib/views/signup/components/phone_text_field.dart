import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool? isEdit;
  final TextInputType keyboard;
  final String validationMsg;

  const PhoneTextField({Key? key,
    required this.controller,
    required this.label,
     this.isEdit = false,
    required this.keyboard,
    this.validationMsg = 'field_required_tr'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppFunctions _appFunctions = AppFunctions();
    var signupPro = context.read<SignUpProvider>();
    String? num = '';
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
                  userValue = userValue!.substring(4);
                  signupPro.forAPIPhoneController.text = userValue!;
                  // signupPro.tempPhoneNoController.text = value;
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
                  signupPro.forAPIPhoneController.text = userValue!;
                  // signupPro.tempPhoneNoController.text = value;
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
            return tr('enter_valid_no_tr');
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
        prefixIcon: TextButton(
          onPressed: () {  },
          child: Text(
            "(+964)",
            style: TextStyle(color: Colors.grey.shade900, fontSize: size.height * AppConstants.screenTopHeadingContent,),
          ),
          ),
        labelStyle: const TextStyle(
            color: AppColors.black,
            // fontSize: size.height * 0.022,
            fontWeight: FontWeight.normal
        ),
      ),
    );
  }


}
