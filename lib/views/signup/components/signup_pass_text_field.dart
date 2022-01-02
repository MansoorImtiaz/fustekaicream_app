import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class SignUpPassTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final bool isPass;
  final bool isRePass;
  final String validationMsg;

  const SignUpPassTextField({Key? key,
    required this.controller,
    required this.label,
    required this.isPass,
    required this.isRePass,
    this.validationMsg = 'field_required_tr'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pro = context.watch<SignUpProvider>();
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(validationMsg);
        }
        if (pro.passController.text != pro.rePassController.text) {
          return tr('pass_should_same_tr');
        }
        if (value.length > 6) {
          return tr('pass_limit_tr');
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: isPass ? pro.isPassVisible : pro.isRePassVisible,
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
        suffixIcon: isPass
            ? IconButton(
          onPressed: () => pro.setPassVisibility(),
          icon: Icon(
            pro.isPassVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.black.withOpacity(0.5),
            size: size.height * AppConstants.passEyeSize,
          ),
        ): IconButton(
          onPressed: () => pro.setRePassVisibility(),
          icon: Icon(
            pro.isRePassVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.black.withOpacity(0.5),
            size: size.height * AppConstants.passEyeSize,
          ),
        ),
      ),
    );
  }
}