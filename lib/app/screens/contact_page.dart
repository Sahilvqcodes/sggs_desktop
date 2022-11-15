import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/contact_page_model.dart';
import 'package:gurugranth_app/app/screens/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

class MyContactPage extends StatefulWidget {
  const MyContactPage({super.key});

  @override
  State<MyContactPage> createState() => _MyContactPageState();
}

class _MyContactPageState extends State<MyContactPage> {
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  late bool _isLoaderVisible;

  void initState() {
    _isLoaderVisible = false;
    super.initState();
  }

  sendContactMessage() async {
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/contact-us'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': _contact.name,
          'email': _contact.email,
          'description': _contact.message,
        },
      ),
    );
    if (res.statusCode == 200) {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.success,
          text: "Successfully Send!",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
      clear();
    }
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  clear() {
    _emailController.clear();
    _messageController.clear();
    _nameController.clear();
  }

  Contact _contact = Contact("", "", "");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: const MyDrawer(),
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Image.asset(
                          "assets/images/logo.png",
                          scale: 6,
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Text(
                          "CONTACT US",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  // prefixIcon: Icon(Icons.mail_outline),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 1.5),
                                  ),
                                ),
                                controller: _nameController,
                                onChanged: (value) {
                                  _contact.name = value;
                                },
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value!.isEmpty || value.length < 4)
                                      ? 'Please enter valid Name'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  // prefixIcon: Icon(Icons.mail_outline),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 1.5),
                                  ),
                                ),
                                controller: _emailController,
                                onChanged: (value) {
                                  _contact.email = value;
                                },
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value!.isEmpty ||
                                          !value.contains("@"))
                                      ? 'Please enter valid email'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Message',

                                  // prefixIcon: Icon(Icons.mail_outline),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 1.5),
                                  ),
                                ),
                                // minLines: 4,
                                maxLines: 5,
                                controller: _messageController,
                                onChanged: (value) {
                                  _contact.message = value;
                                },
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value!.isEmpty)
                                      ? 'Please enter message'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              Container(
                                width: size.width * 0.4,
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      sendContactMessage();
                                    }
                                  },
                                  child: const Text(
                                    "SEND",
                                    style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: const Color(0xFF3D3D3D)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Theme.of(context).colorScheme.primary),
                        child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
