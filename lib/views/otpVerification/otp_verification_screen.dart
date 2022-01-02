import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class OTPVerifyScreen extends StatelessWidget {
  final bool? isForgotPass;
  const OTPVerifyScreen({Key? key, required this.isForgotPass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OTPVerifyBody(isForgotPass: isForgotPass);
  }
}
