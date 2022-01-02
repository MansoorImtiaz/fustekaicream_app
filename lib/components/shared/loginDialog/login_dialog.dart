import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text('alert_tr').tr(),
      content: const Text('alert_msg_tr').tr(),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('cancel_tr').tr(),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(context, AppRoutes().loginScreen),
          child: const Text('login_tr').tr(),
        ),
      ],
    );
  }
}
