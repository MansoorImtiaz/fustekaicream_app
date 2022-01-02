import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class TeamsModel {
  String nacionalidade;
  String name;

  TeamsModel(this.name, this.nacionalidade);
}

class TeamsRepository {
  Future<List<TeamsModel>> findAllAsync() {
    return Future.value([
      TeamsModel("a", "NATIONALS"),
      TeamsModel("b", "NATIONALS"),
      TeamsModel("c", "INTERNATIONALS"),
      TeamsModel("d", "INTERNATIONALS")
    ]);
  }
}
class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  int selectedCat = 0;
  final AppFunctions _appFunctions = AppFunctions();
  AppViewModels listAppViewModel = AppViewModels();
  Connectivity internet = Connectivity();
  bool isOk = false;
  String appBarTitle = 'Stick';

  //============================
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<SubCategories?>? subCategoriesList = [];
  List<Products?>? productsList = [];
  late FlutterLocalNotificationsPlugin localNotification;


  getInternet() async{
    _connectionStatus = await _appFunctions.checkInternet();
  }

  @override
  void initState() {
    super.initState();
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iosInitialize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = false);
        break;
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }
  //============================


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: SafeArea(
            child: _connectionStatus
                ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width * 0.7,
                            child: CustomElevationBtn(
                              title: tr('Notification'),
                              bgColor: AppColors.appColor,
                              textColor: Colors.white,
                              textSize: size.height * 0.03,
                              verPadding: size.height * 0.015,
                              onTap: () {
                                print('Clicked');
                                _showNotifications();
                              },
                            ),
                          ),
                        ],
                      ),
                    /*child: const Text('working ok').tr(),*/
                )
                : Center(child: const Text('no_internet_tr').tr())
        )
    );
  }

  Future<void> _showNotifications() async {
    var androidDetails = const AndroidNotificationDetails(
        "channelId",
        "Local Notification",
        // "This is the description of the notification.",
        importance: Importance.max
    );
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, 'Notify title', 'this is notification body', generalNotificationDetails);
  }

}
