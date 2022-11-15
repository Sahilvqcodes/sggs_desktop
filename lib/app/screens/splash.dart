import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/routes/app_routes.dart';
import 'package:gurugranth_app/app/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateLoginSignup();
  }

  _navigateLoginSignup() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    var token;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    token == null
        ? Get.offAndToNamed(Routes.LOGIN)
        : Get.offAndToNamed(Routes.HOMEPAGE);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/splash_img.jpg"),
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(125),
                ),
              ),
              child: Image.asset(
                "assets/images/logo.png",
                scale: 5,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              child: Image.asset(
                "assets/images/pnb.png",
                scale: 1.2,
              ),
            )
          ],
        )),
      ),
    );
  }
}
