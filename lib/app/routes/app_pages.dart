import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetPage, Transition;
import 'package:gurugranth_app/app/screens/bani_controller.dart';
import 'package:gurugranth_app/app/screens/books_lang/books_lang.dart';
import 'package:gurugranth_app/app/screens/books_lang/languagelist.dart';
import 'package:gurugranth_app/app/screens/contact_page.dart';
import 'package:gurugranth_app/app/screens/forgotPassword/change_password.dart';
import 'package:gurugranth_app/app/screens/forgotPassword/forgot_password.dart';
import 'package:gurugranth_app/app/screens/guru_granth_sahib.dart';
import 'package:gurugranth_app/app/screens/home_page.dart';
import 'package:gurugranth_app/app/screens/splash.dart';
import 'package:gurugranth_app/app/screens/sundarGutka/audio_list.dart';
import 'package:gurugranth_app/app/screens/sundarGutka/books.dart';
import 'package:gurugranth_app/app/screens/sundarGutka/lang_audio.dart';
import 'package:gurugranth_app/app/screens/sundarGutka/sundar_gutka.dart';
import '../screens/login_page.dart';
import '../screens/signup_page.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.SPLASH;
  // static const SECOND = Routes.HOMEPAGE;

  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => MyLoginPage()),
    GetPage(name: Routes.REGISTER, page: () => MyRegisterPage()),
    GetPage(name: Routes.SPLASH, page: () => MySplashScreen()),
    GetPage(name: Routes.HOMEPAGE, page: () => MyHomePage()),
    GetPage(name: Routes.GURUGRANTH, page: () => GuruGranthSahib()),
    GetPage(name: Routes.BANICONTROLLER, page: () => BaniController()),
    GetPage(name: Routes.CONTACTUS, page: () => MyContactPage()),
    GetPage(name: Routes.SUNDARGUTKA, page: () => SundarGutka()),
    GetPage(name: Routes.FORGETPASSWORD, page: () => ForgetPasswordPage()),
    GetPage(name: Routes.CHANGEPASSWORD, page: () => ChangePasswordPage()),
    GetPage(name: Routes.AUDIO, page: () => Audio()),
    GetPage(name: Routes.BOOKSLANG, page: () => LanguageList()),
    GetPage(name: Routes.AUDIOFILE, page: () => AudioFile()),
    GetPage(name: Routes.BOOKSDETAILS, page: () => BooksDetails()),
  ];
}
