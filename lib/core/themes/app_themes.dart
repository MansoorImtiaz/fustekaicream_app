import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class AppThemes{

  static void splash(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays:[
      SystemUiOverlay.top
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }

  static void customTheme(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays:[
      SystemUiOverlay.top,
      SystemUiOverlay.bottom
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
  }
}