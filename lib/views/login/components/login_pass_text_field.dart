import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LoginPassTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final String validationMsg;

  const LoginPassTextField({Key? key,
    required this.controller,
    required this.label,
    this.validationMsg = 'field_required_tr'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pro = context.watch<LoginProvider>();
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(validationMsg);
        }
        if (value.length > 6) {
          return tr('pass_limit_tr');
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: pro.isPassVisible,
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
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          hintText: label,
          labelStyle: const TextStyle(
              color: AppColors.black,
              // fontSize: size.height * 0.022,
              fontWeight: FontWeight.normal
          ),
          suffixIcon: IconButton(
            onPressed: () => pro.setPassVisibility(),
            icon: Icon(
              pro.isPassVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.black.withOpacity(0.5),
              size: size.height * AppConstants.passEyeSize,
            ),
          )
      ),
    );
  }
}