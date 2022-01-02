import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {

  final AppFunctions _appFunctions = AppFunctions();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.deepOrange,
            height: size.height,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "Main",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().navMainScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "SignUp",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().signUpScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "Login",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().loginScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "Change Password",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().changePassScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "OTP",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().otpVerifyScreen(false),);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        // title: user!.emailVerified ? "Email Verified" : "Verify Your Email",
                        title: "Test",
                        bgColor: AppColors.facebook,
                        onTap: () {
                          Navigator.push(context, AppRoutes().testScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "Sub Category",
                        bgColor: AppColors.facebook,
                        onTap: (){
                          Navigator.push(context, AppRoutes().testScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomMaterialButton(
                        btnSize: 0.0135,
                        textSize: 0.020,
                        title: "Logout",
                        bgColor: AppColors.facebook,
                        onTap: () async{
                          // Navigator.pushReplacement(context, AppRoutes().loginNewScreen,);
                        }
                    ),
                    SizedBox(height: size.height * 0.02,),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
