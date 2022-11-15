import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:gurugranth_app/app/widgets/social_login.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _isLoaderVisible;
  late bool _passwordVisible;
  bool value = false;
  bool isChecked = false;
  @override
  void initState() {
    _passwordVisible = true;
    _isLoaderVisible = false;

    super.initState();
  }

  _clear() {
    _emailController.clear();
    _passwordController.clear();
  }

  onForgotPassword(String email) async {
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/forgotpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'name': user.name,
        'email': email,
        // 'password': user.password
      }),
    );
    print(res.body);

    if (res.statusCode == 200) {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.success,
          text: "Code Send Successfully",
          barrierDismissible: false,
          onConfirmBtnTap: (() => Get.offAndToNamed(Routes.CHANGEPASSWORD)),
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    } else {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.error,
          text: "User Not Found;",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: LoaderOverlay(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background.png"),
              ),
            ),
            child: Center(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    scale: 6,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Container(
                    child: Form(
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Text(
                              "FORGET YOUR PASSWORD",
                              style: TextStyle(
                                  color: Color(0xFFFE9F33),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.mail_outline),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3D3D3D), width: 1.5),
                                ),
                              ),
                              controller: _emailController,
                              onChanged: (value) {
                                // user.email = value;
                              },
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value!.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value))
                                    ? 'Please enter valid email'
                                    : null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Container(
                              width: size.width,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    onForgotPassword(_emailController.text);
                                  }
                                },
                                child: const Text(
                                  "SEND CODE",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 20),
        child: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
