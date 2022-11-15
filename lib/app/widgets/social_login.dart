import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/social_login_model.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  appleLogin(BuildContext context, String? givenName, String? email,
      String? userIdentifier) async {
    print("givenName $givenName");
    print("email $email");
    print("userIdentifier $userIdentifier");
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/appleregister'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': givenName ?? "null",
        'email': email ?? "null",
        'apple_token': userIdentifier ?? ""
      }),
    );
    print(res.body);
    var userData = SocialLogin.fromJson(jsonDecode(res.body));
    if (res.statusCode == 200) {
      Get.toNamed(Routes.HOMEPAGE);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', userData.success?.appleToken ?? "");
      sharedPreferences.setString(
          'userId', userData.success?.id.toString() ?? "");
      sharedPreferences.setString('userName', userData.success?.name ?? "");
    } else if (res.statusCode == 401) {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.error,
          text: "Email Already Exist",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: Color(0xFFC2C2C2),
                height: 1,
                width: size.width * 0.43,
              ),
              Text("OR"),
              Container(
                color: Color(0xFFC2C2C2),
                height: 1,
                width: size.width * 0.43,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //     height: 44,
              //     width: 78,
              //     child: OutlinedButton(
              //       onPressed: () {},
              //       child: Image.asset("assets/icons/fb.png"),
              //     )),
              // const SizedBox(
              //   width: 21,
              // ),

              SizedBox(
                  height: 44,
                  width: 78,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () {
                      googleSignInProcess(context);
                    },
                    child: Image.asset("assets/icons/google.png"),
                  )),
              const SizedBox(
                width: 21,
              ),
              SizedBox(
                  height: 44,
                  width: 78,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () async {
                      final credential =
                          await SignInWithApple.getAppleIDCredential(
                        scopes: [
                          AppleIDAuthorizationScopes.email,
                          AppleIDAuthorizationScopes.fullName,
                        ],
                      );
                      appleLogin(context, credential.givenName,
                          credential.email, credential.userIdentifier);
                      // print("credential.email ${credential.userIdentifier}");
                      // print("credential.email ${credential.authorizationCode}");
                      // print("credential.email ${credential.identityToken}");
                      // print("credential.email ${credential.email}");
                      // print("credential.email ${credential.givenName}");
                    },
                    child: Image.asset("assets/icons/apple.png"),
                  )),
              const SizedBox(
                width: 21,
              ),
              // SizedBox(
              //     height: 44,
              //     width: 78,
              //     child: OutlinedButton(
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0))),
              //       ),
              //       onPressed: () {},
              //       child: Image.asset("assets/icons/fb.png"),
              //     )),
            ],
          ),
        ],
      ),
    );
  }
}

GoogleSignIn? _googleSignIn;

void googleSignInProcess(BuildContext context) async {
  if (Platform.isAndroid) {
    _googleSignIn = GoogleSignIn();
    // Android-specific code
  } else if (Platform.isIOS) {
    // iOS-specific code
    _googleSignIn = GoogleSignIn(
        clientId:
            "632788242950-ve0fc3kj3ctsk6q1hra68u1rdqsd4a9k.apps.googleusercontent.com");
  }
  if (await _googleSignIn!.isSignedIn()) {
    handleSignOut();
  }
  GoogleSignInAccount? googleUser;
  GoogleSignInAuthentication googleSignInAuthentication;
  try {
    googleUser = (await _googleSignIn!.signIn());
    if (googleUser != null) {
      googleSignInAuthentication = await googleUser.authentication;

      print(googleSignInAuthentication.accessToken);
    }
  } catch (error) {
    print(error);
  }

  if (await _googleSignIn!.isSignedIn()) {
    print(googleUser?.email);
    print(googleUser?.displayName);
    print(googleUser?.photoUrl);
    print(googleUser?.id);
    googleLogin(
        context, googleUser?.email, googleUser?.displayName, googleUser?.id);
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("sucess : ${googleUser?.email}" ?? "")));

  }
}

Future<void> handleSignOut() => _googleSignIn!.disconnect();
googleLogin(BuildContext context, String? email, String? displayName,
    String? id) async {
  print("email $email");
  print("displayName $displayName");
  print("id $id");
  final http.Response res = await http.post(
    Uri.parse('http://143.244.139.23:94/api/gmailregister'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': displayName ?? "",
      'email': email ?? "",
      'gmail_token': id ?? ""
    }),
  );
  print(res.body);
  print(res.statusCode);
  var userData = SocialLogin.fromJson(jsonDecode(res.body));
  if (res.statusCode == 200) {
    print("googleLogin");
    // if (res != null) {
    Get.toNamed(Routes.HOMEPAGE);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', userData.success?.gmailToken ?? "");
    sharedPreferences.setString(
        'userId', userData.success?.id.toString() ?? "");
    sharedPreferences.setString('userName', userData.success?.name ?? "");
  } else if (res.statusCode == 401) {
    CoolAlert.show(
        width: 50,
        context: context,
        type: CoolAlertType.error,
        text: "Email Already Exist",
        confirmBtnColor: Theme.of(context).colorScheme.primary);
  }
}
