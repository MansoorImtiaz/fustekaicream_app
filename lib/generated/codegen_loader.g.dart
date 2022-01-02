// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar_IQ = {
  "eng_tr": "إنجليزي",
  "arb_tr": "عربي",
  "home_tr": "الصفحة الرئيسية",
  "categories_tr": "فئات",
  "me_tr": "أنا",
  "products_tr": "منتجات",
  "campaigns_tr": "الحملات",
  "product_categories_tr": "فئات المنتجات",
  "contest_campaigns_tr": "المسابقات والحملات",
  "promotions_offers_tr": "الترقيات والعروض",
  "videos_ads_tr": "مقاطع فيديو (إعلانات)",
  "login_tr": "تسجيل الدخول",
  "email_mobile_tr": "البريد الإلكتروني/الجوال",
  "password_tr": "كلمه السر",
  "forgot_pass_tr": "هل نسيت كلمة السر؟",
  "register_tr": "يسجل",
  "or_tr": "أو",
  "facebook_tr": "فيسبوك",
  "google_tr": "جوجل",
  "login_bottom_txt_tr": "2021 - حقوق الطبع والنشر لمجموعة Shopini"
};
static const Map<String,dynamic> en_US = {
  "eng_tr": "English",
  "arb_tr": "Arabic",
  "home_tr": "Home",
  "categories_tr": "Categories",
  "me_tr": "Me",
  "products_tr": "Products",
  "campaigns_tr": "Campaigns",
  "product_categories_tr": "Product Categories",
  "contest_campaigns_tr": "Contest & Campaigns",
  "promotions_offers_tr": "Promotions & Offers",
  "videos_ads_tr": "Videos (Ads)",
  "login_tr": "Login",
  "email_mobile_tr": "Email/Mobile",
  "password_tr": "Password",
  "forgot_pass_tr": "Forgot Password?",
  "register_tr": "Register",
  "or_tr": "OR",
  "facebook_tr": "Facebook",
  "google_tr": "Google",
  "login_bottom_txt_tr": "2021 - Copyright Shopini Group"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar_IQ": ar_IQ, "en_US": en_US};
}
