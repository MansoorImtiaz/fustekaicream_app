import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';

enum LanguagesMethod { arabic, english, }

class AppLangChange extends StatefulWidget {
  final int? currentLang;

  const AppLangChange({
    Key? key,
    required this.currentLang
  }) : super(key: key);

  @override
  _AppLangChangeState createState() => _AppLangChangeState(crtLang: currentLang);
}

class _AppLangChangeState extends State<AppLangChange> {
  int? crtLang;
  _AppLangChangeState({required this.crtLang});

  final SharedPref _sharedPref =  SharedPref();
  LanguagesMethod? _method = LanguagesMethod.arabic;


  void _handleLanguageChange(int? value) {

      switch (value) {
        case 0:
          print('in 0 '+ crtLang.toString());
          _sharedPref.setIsEngActive(false);
          _sharedPref.setLang('ar');
          context.setLocale(const Locale('ar','IQ'));
          Navigator.pop(context);
          reloadScreens();
          break;
        case 1:
          print('in 1 '+ crtLang.toString());
          _sharedPref.setIsEngActive(true);
          _sharedPref.setLang('en');
          context.setLocale(const Locale('en','US'));
          Navigator.pop(context);
          reloadScreens();
          break;
      }
  }

@override
  void initState() {
    super.initState();
    crtLang == 0 ? _method = LanguagesMethod.arabic: _method = LanguagesMethod.english ;
  }

  void reloadScreens(){

    if(AppConstants.currentScreen.contains(AppConstants.login)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.login));

    }else if(AppConstants.currentScreen.contains(AppConstants.signup)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.signup));

    }else if(AppConstants.currentScreen.contains(AppConstants.categories)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.categories));

    }else if(AppConstants.currentScreen.contains(AppConstants.subCategories)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.subCategories));

    }else if(AppConstants.currentScreen.contains(AppConstants.me)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.me));

    }else if(AppConstants.currentScreen.contains(AppConstants.products)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.products));

    }else if(AppConstants.currentScreen.contains(AppConstants.campaigns)){

      EventBusUtils.getInstance().fire(UpdateAppLanguage(AppConstants.campaigns));
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: size.width,
                child: Text(
                  tr('choose_lang_tr'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.height * AppConstants.screenTopHeading, color: AppColors.appColor, fontWeight: FontWeight.w500),
                )),
            SizedBox(height: size.height * 0.03,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.030),
              child: RadioListTile<LanguagesMethod>(
                title: Row(
                  children: [
                    SizedBox(
                        height: size.height * 0.04,
                        width: size.width * 0.06,
                        child: SvgPicture.asset(AppAssets.iraqFlag)
                    ),
                    SizedBox(width: size.width * 0.02,),
                    Text('عربي', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent,),).tr()
                  ],
                ),
                value: LanguagesMethod.arabic,
                groupValue: _method,
                onChanged: (LanguagesMethod? value) {
                  setState(() {
                    _method = value;
                    print(_method!.index);
                    _handleLanguageChange(_method!.index);
                  });
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.030),
              child: RadioListTile<LanguagesMethod>(
                title: Row(
                  children: [
                    SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.06,
                        child: SvgPicture.asset(AppAssets.ukFlag)
                    ),
                    SizedBox(width: size.width * 0.02,),
                    Text('English', style: TextStyle(fontSize: size.height * AppConstants.screenTopHeadingContent,),).tr(),

                  ],
                ),
                value: LanguagesMethod.english,
                groupValue: _method,
                onChanged: (LanguagesMethod? value) {
                  setState(() {
                    _method = value;
                    print(_method!.index);
                    _handleLanguageChange(_method!.index);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
