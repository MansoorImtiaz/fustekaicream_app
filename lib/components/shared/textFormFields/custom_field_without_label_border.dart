import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class CustomFieldWithoutLabelBorder extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String validationMsg;
  final TextInputType keyboard;

  const CustomFieldWithoutLabelBorder({Key? key,
    required this.controller,
    required this.icon,
    required this.label,
    required this.validationMsg,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMsg;
          }
          return null;
        },
        controller: controller,
        textInputAction: TextInputAction.done,
        keyboardType: keyboard,
        style: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.020
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: size.height * 0.020,
              fontWeight: FontWeight.normal
          ),
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(0.5),
            size: size.height * 0.03,
          ),
        )
    );
  }
}
