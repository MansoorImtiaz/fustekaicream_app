import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class AppRoutes{

  PageTransition loginScreen = PageTransition(
      child: const LoginScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition signUpScreen = PageTransition(
      child: const SignUpScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition changePassScreen = PageTransition(
      child: const ChangePassScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition otpVerifyScreen(bool? isForgotPass) => PageTransition(
      child: OTPVerifyScreen(isForgotPass: isForgotPass),
      type: PageTransitionType.bottomToTop
  );

  PageTransition navMainScreen = PageTransition(
      child: const NavMainScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition productsScreen(bool isAppBar) => PageTransition(
      child: ProductsScreen(isAppBar: isAppBar,),
      type: PageTransitionType.bottomToTop
  );

  PageTransition tempScreen = PageTransition(
      child: const TempScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition testScreen = PageTransition(
      child: const TestScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition meScreen = PageTransition(
      child: const MeScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition categoriesScreen(bool isAppBar) => PageTransition(
      child: CategoryScreen(isAppBar: isAppBar,),
      type: PageTransitionType.bottomToTop
  );


  PageTransition subCategoriesScreen(String id, String title) => PageTransition(
      child: SubCategoriesScreen(catId: id,title: title,),
      type: PageTransitionType.bottomToTop
  );

  PageTransition productsDetailScreen(String id, String price) => PageTransition(
      child: ProductsDetailScreen(productId: id, price: price,),
      type: PageTransitionType.bottomToTop
  );

  PageTransition contestAndCampaignsScreen(bool isAppBar) => PageTransition(
      child: ContestAndCampaignsScreen(isAppBar: isAppBar,),
      type: PageTransitionType.bottomToTop
  );

  PageTransition mekanoUploadingScreen = PageTransition(
      child: const MekanoUploadingScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition instantGiftsScreen = PageTransition(
      child: const InstantGiftsScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition campaignsGalleryScreen = PageTransition(
      child: const CampaignsGalleryScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition lotteryCampaignScreen = PageTransition(
      child: const LotteryCampaignScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition instantGiftListScreen = PageTransition(
      child: const InstantGiftListScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition lotteryRewardListScreen = PageTransition(
      child: const LotteryRewardListScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition mekanoGiftListScreen = PageTransition(
      child: const MekanoGiftListScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition editProfileScreen = PageTransition(
      child: const EditProfileScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition viewProfileScreen = PageTransition(
      child: const ViewProfileScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition forgotPassScreen = PageTransition(
      child: const ForgotPassScreen(),
      type: PageTransitionType.bottomToTop
  );

  PageTransition mekanoUploadedImagesScreen = PageTransition(
      child: const MekanoUploadedImagesScreen(),
      type: PageTransitionType.bottomToTop
  );

}