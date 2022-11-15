import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/local_sggs.dart';
import 'package:gurugranth_app/app/screens/multi_view_drawer.dart';
import 'package:gurugranth_app/app/widgets/custom_english_keyboard.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../models/search_data_models.dart';
import '../routes/app_routes.dart';
import '../utilities/sggs_handler.dart';
import '../widgets/custom_keyboard.dart';
import '../widgets/punjabi_keyboard.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;

enum keyboardLanguage { English, Punjabi }

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _nodeText7 = FocusNode();
  final FocusNode _nodeText5 = FocusNode();
  //This is only for custom keyboards
  final custom1Notifier = ValueNotifier<String>("");
  TextEditingController textController = TextEditingController();
  keyboardLanguage? _language = keyboardLanguage.English;
  // final translator = GoogleTranslator();
  // String trans = "";
  // final RxString _textFieldChange = "".obs;
  // void _incrementCounter(String text) {
  //   print("_textFieldChange");
  //   print("output $trans");
  //   _textFieldChange.value = text;
  //   print(_textFieldChange.value);
  // }
  ScrollController? _controller;
  late bool isDrawer;
  void initState() {
    isDrawer = false;

    super.initState();
  }

  // List<Data>? searchData;
  // Future getSearchData(String text) async {
  //   print("getSearchData $text");
  //   String url = _language == keyboardLanguage.English
  //       ? 'http://143.244.139.23:94/api/search?name=$text'
  //       : "http://143.244.139.23:94/api/searchpunjabi?name=$text";
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   String json = response.body;
  //   // print(json);
  //   var _searchData = SearchData.fromJson(jsonDecode(response.body));
  //   searchData = _searchData.data;
  //   // print(response.statusCode);
  //   // guruGranthData = guruGranth.data;
  //   // print(guruGranthData);
  //   return searchData;
  // }
  addPage(String _id) async {
    var _angData = await SggsHandler.addMultiviewData(context, _id);
    print("_angData ${_angData}");
    List<String> _data = [];
    _data.add(jsonEncode(_angData));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("multiview", jsonEncode(_angData));
    var localMultiview = prefs.getStringList("multiview");
    print("localMultiview $localMultiview");
  }

  // addPage(String gurugranth_id) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? userId = sharedPreferences.getString("userId");
  //   final http.Response res = await http.post(
  //     Uri.parse('http://143.244.139.23:94/api/multiview'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'user_id': userId ?? "",
  //       'gurugranth_id': gurugranth_id,
  //     }),
  //   );
  //   String json = res.body;
  //   Map<String, dynamic> body = jsonDecode(json);
  //   print("json ${body["success"]}");
  //   if (body["success"] == "SuccessFully Created") {
  //     print("MultiView Added Successsfully");
  //     CoolAlert.show(
  //         width: 50,
  //         context: context,
  //         type: CoolAlertType.success,
  //         text: "Added Successfully",
  //         confirmBtnColor: Theme.of(context).colorScheme.primary);
  //   } else {
  //     CoolAlert.show(
  //         width: 50,
  //         context: context,
  //         type: CoolAlertType.warning,
  //         text: "${body["success"]}",
  //         confirmBtnColor: Theme.of(context).colorScheme.primary);
  //   }
  // }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[220],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText7,
          footerBuilder: (_) => CounterKeyboard(
            notifier: custom1Notifier,
            setStateValue: (String value) {
              print(value);
              print("setStateValue");
              setState(() {
                textController.text = value;
              });
            },
            textController: textController,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size.height);
    // print(size.width);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: isDrawer ? const MyDrawer() : const MultiviewDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/background.png"),
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.05),
                          width: size.width,
                          height: 150,
                          color: Theme.of(context).colorScheme.primary,
                          child: Container(
                            height: 150,
                            child: Column(
                              children: [
                                _language == keyboardLanguage.English
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          top: 52,
                                          // bottom: 35,
                                          left: size.width * 0.03,
                                          right: size.width * 0.03,
                                        ),
                                        // height: 50.0,
                                        // width: size.width * 0.8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: TextField(
                                          textInputAction:
                                              TextInputAction.search,
                                          controller: textController,
                                          // keyboardType: TextInputType.none,
                                          decoration: InputDecoration(
                                            // fillColor: Colors.white,

                                            hintText: "Search",
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15.0, top: 15.0),
                                            suffixIcon: IconButton(
                                              icon: Container(
                                                  height: size.height,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: const Color(
                                                          0xFF3D3D3D)),
                                                  child: const Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  )),
                                              onPressed: () {},
                                              iconSize: 30.0,
                                            ),
                                          ),
                                          onChanged: (text) async {
                                            setState(() {});
                                          },
                                          // onTap: () {

                                          // },
                                        ),
                                      )
                                    : Container(
                                        height: 100,
                                        child: KeyboardActions(
                                          config: _buildConfig(context),
                                          child: KeyboardCustomInput<String>(
                                            focusNode: _nodeText7,
                                            // height: 65,
                                            notifier: custom1Notifier,
                                            builder: (context, val, hasFocus) {
                                              textController.text = val;

                                              return Container(
                                                margin: EdgeInsets.only(
                                                  top: 40,
                                                  // bottom: 35,
                                                  left: size.width * 0.03,
                                                  right: size.width * 0.03,
                                                ),
                                                // height: 50.0,
                                                width: size.width * 0.8,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Colors.white),
                                                child: TextField(
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  controller:
                                                      TextController(text: val),
                                                  keyboardType:
                                                      TextInputType.none,
                                                  decoration: InputDecoration(
                                                    // fillColor: Colors.white,

                                                    hintText: "Search",
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            top: 15.0),
                                                    suffixIcon: IconButton(
                                                      icon: Container(
                                                          height: size.height,
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: const Color(
                                                                  0xFF3D3D3D)),
                                                          child: const Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          )),
                                                      onPressed: () {
                                                        // showModalBottomSheet(
                                                        //     context: context,
                                                        //     builder: (context) =>
                                                        //         Container(
                                                        //           color:
                                                        //               Colors.grey[900],
                                                        //           height: 280,
                                                        //         ));
                                                      },
                                                      iconSize: 30.0,
                                                    ),
                                                  ),
                                                  onChanged: (text) async {},
                                                  // onTap: () {

                                                  // },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                Row(
                                  children: [
                                    Radio<keyboardLanguage>(
                                      value: keyboardLanguage.English,
                                      groupValue: _language,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      onChanged: (keyboardLanguage? value) {
                                        setState(() {
                                          _language = value;
                                          print("_language $_language");
                                        });
                                      },
                                    ),
                                    Text(
                                      "English",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Radio<keyboardLanguage>(
                                      value: keyboardLanguage.Punjabi,
                                      groupValue: _language,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      onChanged: (keyboardLanguage? value) {
                                        setState(() {
                                          _language = value;
                                          print("_language $_language");
                                        });
                                      },
                                    ),
                                    Text(
                                      "Punjabi",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: size.height * 0.025,
                          left: size.width * 0.3,
                          right: size.width * 0.3,
                          child: Container(
                            height: 40,
                            width: size.width * 0.4,
                            color: const Color(0xFF3D3D3D),
                            child: const Center(
                              child: Text(
                                "SEARCH WORLD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xFF3D3D3D)),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                isDrawer = true;
                              });
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/logo.png",
                                scale: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.GURUGRANTH);
                                },
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  child: const Center(
                                    child: Text(
                                      "Shri Guru Granth Sahib Ji",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Container(
                                width: size.width,
                                height: 60,
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.SUNDARGUTKA);
                                        },
                                        child: Container(
                                          height: 45,
                                          width: size.width * 0.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: const Center(
                                            child: Text(
                                              "Sundar Gutka",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: size.width * 0.18,
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: const Color(0xFF3D3D3D)),
                                        child: Image.asset(
                                            "assets/icons/sundar.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Container(
                                width: size.width,
                                height: 60,
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isDrawer = false;
                                          });
                                          _scaffoldKey.currentState!
                                              .openDrawer();
                                        },
                                        child: Container(
                                          height: 45,
                                          width: size.width * 0.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: const Center(
                                            child: Text(
                                              "Multi View",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: size.width * 0.18,
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                            color: const Color(0xFF3D3D3D)),
                                        child: Image.asset(
                                          "assets/icons/multi.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              // Container(
                              //   width: size.width,
                              //   height: 60,
                              //   child: Stack(
                              //     // mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Center(
                              //         child: InkWell(
                              //           onTap: () {
                              //             Get.toNamed(Routes.BANICONTROLLER);
                              //           },
                              //           child: Container(
                              //             height: 45,
                              //             width: size.width * 0.5,
                              //             decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(5.0),
                              //                 color: Theme.of(context)
                              //                     .colorScheme
                              //                     .primary),
                              //             child: const Center(
                              //               child: Text(
                              //                 "Bani Controller",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 16),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Positioned(
                              //         left: size.width * 0.18,
                              //         child: Container(
                              //           height: 55,
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(30.0),
                              //               color: const Color(0xFF3D3D3D)),
                              //           child: Image.asset(
                              //               "assets/icons/bani.png"),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        textController.text.isNotEmpty &&
                                textController.text.length >= 2
                            ? Positioned(
                                child: Container(
                                  height:
                                      size.height - (size.height * 0.1 + 120),
                                  color: Colors.white,
                                  child: FutureBuilder(
                                    future:
                                        _language == keyboardLanguage.English
                                            ? SggsHandler.getEnglishSearch(
                                                context, textController.text)
                                            : SggsHandler.getPunjabiSearch(
                                                context, textController.text),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.data.length == 0) {
                                        return SizedBox(
                                          width: size.width,
                                          child: Container(
                                              width: size.width * 0.4,
                                              margin: EdgeInsets.only(
                                                  top: size.height * 0.2,
                                                  left: size.width * 0.4,
                                                  right: size.width * 0.4),
                                              child: Text(
                                                "Data Not Found!",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 3, 53, 94),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        );
                                      }
                                      List<AngData> _data = snapshot.data;
                                      print("_data $_data");
                                      return MediaQuery.removePadding(
                                        removeTop: true,
                                        context: context,
                                        child: ListView.builder(
                                          controller: _controller,
                                          itemCount: _data.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18,
                                                  left: 10,
                                                  right: 10,
                                                  top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${_data[index].id} .",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              Routes.GURUGRANTH,
                                                              arguments: [
                                                                int.parse(
                                                                    _data[index]
                                                                        .ang!),
                                                                int.parse(
                                                                    _data[index]
                                                                        .id!)
                                                              ]);
                                                        },
                                                        child: _language ==
                                                                keyboardLanguage
                                                                    .English
                                                            ? Text(
                                                                _data[index]
                                                                        .english ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          3,
                                                                          53,
                                                                          94),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )
                                                            : Text(
                                                                _data[index]
                                                                        .name ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          3,
                                                                          53,
                                                                          94),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      radius: 20,
                                                      child: InkWell(
                                                        onTap: () {
                                                          addPage(_data[index]
                                                              .id
                                                              .toString());
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 35,
                                                        ),
                                                      ), //Text
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
