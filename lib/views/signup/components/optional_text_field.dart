import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class OptionalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isEmail;
  final bool isSurname;
  final bool isReadOnly;
  final TextInputType keyboard;
  final String validationMsg;

  const OptionalTextField({Key? key,
    required this.controller,
    required this.label,
    this.isEmail = false,
    this.isSurname = false,
    this.isReadOnly = false,
    required this.keyboard,
    this.validationMsg = 'field_required_tr'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isEmailValid(String value) {
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
      return emailValid;
    }
    return  TextFormField(
      readOnly: isReadOnly,
      validator: (value) {
        if(isEmail){
          if (value!.isNotEmpty) {
            if (!isEmailValid(value)) {
              return tr('enter_valid_email_tr');
            }
          }
        }
        if(isSurname){
          if (value!.isNotEmpty) {
            if(value.length < 3){
              return tr('name_limit_tr');
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
        labelStyle: const TextStyle(
            color: AppColors.black,
            // fontSize: size.height * 0.022,
            fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}
