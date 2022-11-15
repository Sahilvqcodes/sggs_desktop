import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gurugranth_app/app/widgets/social_login.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_resp.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
    _loadUserEmailPassword();
    super.initState();
  }

  _clear() {
    _emailController.clear();
    _passwordController.clear();
  }

  onLoginTap() async {
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'name': user.name,
        'email': user.email,
        'password': user.password
      }),
    );
    print(res.body);
    var userData = LoginSignupResp.fromJson(jsonDecode(res.body));
    if (res.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', userData.success!.email!);

      final SharedPreferences sharedPreferences2 =
          await SharedPreferences.getInstance();
      sharedPreferences2.setString('userId', userData.success!.id!.toString());
      sharedPreferences2.setString(
          'userName', userData.success!.name!.toString());

      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.success,
          text: "Login successfully!",
          confirmBtnColor: Theme.of(context).colorScheme.primary);

      print("Successfully login");
      Get.offAllNamed(Routes.HOMEPAGE);
      _clear();
      if (isChecked) {
        _handleRemeberme();
      }
    } else {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.error,
          text: "Invalid Email/Password!",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  void _handleRemeberme() {
    print("SharedPreferences");

    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", true);
        prefs.setString('email', user.email);
        prefs.setString('password', user.password);
      },
    );
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          isChecked = true;
        });
        _emailController.text = _email;
        _passwordController.text = _password;
        user.email = _email;
        user.password = _password;
      }
    } catch (e) {
      print(e);
    }
  }

  User user = User("", "", "");
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
                              "LOGIN YOUR ACCOUNT",
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
                                user.email = value;
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
                              height: size.height * 0.03,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3D3D3D), width: 1.5),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: _passwordVisible
                                        ? Colors.grey
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _passwordVisible,
                              controller: _passwordController,
                              onChanged: (value) {
                                user.password = value;
                              },
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value!.isEmpty || value.length < 6)
                                    ? 'Please Enter valid Password'
                                    : null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: this.value,
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          this.value = newValue!;
                                          isChecked = true;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Remember Me?",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.FORGETPASSWORD);
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Container(
                              width: size.width,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    onLoginTap();
                                  }
                                },
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Container(
                              width: size.width,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      width: 1.0,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary),
                                child: const Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            SocialLogins()
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
