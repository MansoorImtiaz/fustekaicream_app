import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

// final SharedPref _sharedPref =  SharedPref();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

    runApp(
        EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'IQ')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en', 'US'),
            child: const StarterScreen()
        )
    );
  });
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StarterScreen(),
    );
  }
}*/
