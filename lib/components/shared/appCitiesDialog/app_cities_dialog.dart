import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/EventBus/event_bus_model.dart';
import 'package:fusteka_icecreem/core/EventBus/singleton_event_bus.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class AppCitiesDialog extends StatefulWidget {
  List<LocalCitiesModel>? citiesList;

  AppCitiesDialog({
    Key? key,
    required this.citiesList,
  }) : super(key: key);

  @override
  _AppCitiesDialogState createState() => _AppCitiesDialogState(citiesList: citiesList);
}

class _AppCitiesDialogState extends State<AppCitiesDialog> {
  List<LocalCitiesModel>? citiesList;
  _AppCitiesDialogState({required this.citiesList});

  final AppFunctions _appFunctions = AppFunctions();
  final SharedPref _sharedPref =  SharedPref();
  // int? _langValue =  0;

  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signupPro = context.read<SignUpProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02,),
              SizedBox(
                  width: size.width,
                  child: Text(
                    tr('choose_city_tr'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size.height * 0.030, color: AppColors.appColor, fontWeight: FontWeight.w500),
                  )),
              SizedBox(height: size.height * 0.03,),
              Expanded(
                child: ListView.builder(
                    itemCount : citiesList!.length,
                    shrinkWrap: true, // Use  children total size
                    itemBuilder : (context, index){
                      return GestureDetector(
                        onTap: () {
                          signupPro.cityController.text = citiesList![index].cityName!;
                          Navigator.pop(context);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(citiesList![index].cityName!, style:  TextStyle(color: Colors.black54, fontSize: size.height * 0.025, ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
