import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/guru_granth_data.dart';
import 'package:gurugranth_app/app/screens/Drawer.dart';
import 'package:gurugranth_app/app/screens/multi_view_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../models/audio_model.dart';
import '../../models/books_model.dart';
import '../../widgets/multiselect_lang.dart';

// List<String> list = <String>['car', 'Train', 'Bus', 'Flight'];

class AudioFile extends StatefulWidget {
  AudioFile({
    Key? key,
    // this.audioList,
  }) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // GoogleTranslator translator = GoogleTranslator();
  // LanguageModel? _choosenValue;
  // List<LanguageModel> _languages = List.empty(growable: true);

  // String dropdownValue = list.first;
  String dropdownValue = 'Translations';
  late bool isDrawer;
  bool? isMultiviewDrawer;
  bool value = false;
  bool buttonenabled = false;
  int i = 1;
  String? userId;

  AudioM? _audioFile;

  void initState() {
    isDrawer = false;
    isMultiviewDrawer = false;
    super.initState();
    print("Get.arguments ${Get.arguments}");
    _audioFile = Get.arguments;
    // setState(() {
    // i = Get.arguments ?? 1;
    // });
    //
    // _languages.add(LanguageModel(code: 'en', name: 'English'));
    // _languages.add(LanguageModel(code: 'hin', name: 'Hindi'));
    // _languages.add(LanguageModel(code: 'ar', name: 'Arabic'));
    // _languages.add(LanguageModel(code: 'gu', name: 'Gujarati'));

    // translations();
    // getUserId();
  }

  List<String> _selectedItems = [
    'English',
  ];

  // List selectedLanguage = [];
  void _showMultiSelect() async {
    // _selectedItems.add(LanguageModel(code: 'en', name: 'English'));
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'English',
      // 'Hindi',
      // 'Arabic',
      // 'Gujarati',
      // "Spanish"
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          selectedItems: _selectedItems,
        );
      },
    );
    // final List<LanguageModel> nullResult = [];
    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
        print(_selectedItems);
        // _selectedItems.forEach((element) {
        //   print(element.name);
        //   selectedLanguage.add(element.name);
        // });
      });
    }
  }
  // getUserId() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   userId = sharedPreferences.getString("userId");
  // }

  String? bookName;
  // translations() async {
  //   await translator
  //       .translate("Sri Guru Granth Sahib Ji", to: "pa")
  //       .then((value) {
  //     setState(() {
  //       bookName = value.toString();
  //     });

  //     // print(bookName);
  //   });
  // }
  _launchURLBrowser(String? audioLink) async {
    var url = Uri.parse(audioLink!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  addPage(String gurugranth_id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/multiview'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId ?? "",
        'gurugranth_id': gurugranth_id,
      }),
    );
    String json = res.body;
    Map<String, dynamic> body = jsonDecode(json);
    print("json ${body["success"]}");
    if (body["success"] == "SuccessFully Created") {
      print("MultiView Added Successsfully");
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.success,
          text: "Added Successfully",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    } else {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.warning,
          text: "${body["success"]}",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }
  }

  // var guruGranth;
  List<Lines>? guruGranthData;

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: isDrawer ? const MyDrawer() : const MultiviewDrawer(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: size.height * 0.08),
                width: size.width,
                height: 120,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xFF3D3D3D)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDrawer = true;
                            });
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.03),
                        height: 40,
                        width: size.width * 0.31,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                            color: Color(0xFF3D3D3D)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDrawer = false;
                            });
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/multi_view.png",
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Multi-View",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        height: 40,
                        width: size.width * 0.09,
                        decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            addPage(guruGranthData?[0].id.toString() ?? "");
                          },
                          child: Center(
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF3D3D3D),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _showMultiSelect,
                        child: Container(
                            margin: EdgeInsets.only(left: size.width * 0.025),
                            height: 40,
                            width: size.width * 0.38,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3D3D), //<-- SEE HERE
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Translation",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 60,
              // ),
              Padding(
                padding: const EdgeInsets.all(25.0),
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
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xFF3D3D3D)),
                child: Image.asset("assets/icons/audio.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${_audioFile?.audioName}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: Align(
              //       alignment: Alignment.topLeft,
              //       child: Text(
              //         "English Language",
              //         style: TextStyle(
              //             fontSize: 18, fontWeight: FontWeight.w500),
              //       )),
              // ),
              Container(
                  // height: 550,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            // onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Telugulan()),
                            // );
                            // },
                            // onTap: () {
                            //   Get.toNamed(Routes.AUDIO);
                            // },
                            // child: Container(
                            //   height: 45,
                            //   width: size.width * 0.5,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5.0),
                            //       color:
                            //           Theme.of(context).colorScheme.primary),
                            //   child: Center(
                            //     child: Text(
                            //       "${_audioFile?.audioName}",
                            //       style: TextStyle(
                            //           color: Colors.white, fontSize: 16),
                            //     ),
                            //   ),
                            // ),
                            // ),
                            Expanded(
                              child: Text(
                                _audioFile?.audioName ?? "",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.01),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURLBrowser(_audioFile?.audioLink);
                              },
                              child: Icon(
                                Icons.download,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Divider(
                      //   height: 0.8,
                      //   color: Colors.grey,
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
