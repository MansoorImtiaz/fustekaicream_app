import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class StarterScreen extends StatefulWidget {
  const StarterScreen({Key? key}) : super(key: key);

  @override
  _StarterScreenState createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {

  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      FirebaseMessaging.instance.getInitialMessage();

      ///It will work when app will in foreground
      FirebaseMessaging.onMessage.listen((message) {
        print(message.notification!.title);
        print(message.notification!.body);
      });
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _auth = Firebase.initializeApp();
    _appFunctions.customizeLoadings(AppColors.appColor, AppColors.white);
    return FutureBuilder(
      // future: Init.instance.initialize(),
        future: Firebase.initializeApp(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            print('something went wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider<LoginProvider>(
                create: (_) => LoginProvider(),),
              ChangeNotifierProvider<SignUpProvider>(
                create: (_) => SignUpProvider(),),
              ChangeNotifierProvider<ChangePassProvider>(
                create: (_) => ChangePassProvider(),),
              ChangeNotifierProvider<AppProvider>(
                create: (_) => AppProvider(),)
            ],
            child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: AppSettings.appName,
                home: const SplashScreen(),
                theme: ThemeData(
                  primaryColor: AppColors.appColor,
                  indicatorColor: AppColors.appColor,
                  splashColor: AppColors.appColor,
                  textTheme: GoogleFonts.cairoTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                // home: const TestScreen(),
                // home: const ProductsDetailScreen(productId: '16'),
                color: AppColors.appColor,
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init()
            ),
          );
        }
    );
  }
}





