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

import '../../routes/app_routes.dart';
import '../../widgets/multiselect_lang.dart';

// List<String> list = <String>['car', 'Train', 'Bus', 'Flight'];

class SundarGutka extends StatefulWidget {
  const SundarGutka({super.key});

  @override
  State<SundarGutka> createState() => _SundarGutkaState();
}

class _SundarGutkaState extends State<SundarGutka> {
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
  void initState() {
    isDrawer = false;
    isMultiviewDrawer = false;
    super.initState();
    print(Get.arguments);
    // setState(() {
    i = Get.arguments ?? 1;
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
  Future getAng(String id) async {
    String url = 'http://143.244.139.23:94/api/ang?id=$id';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    String json = response.body;
    var guruGranth = Gurugranth.fromJson(jsonDecode(response.body));
    guruGranthData = guruGranth.data;
    // print(guruGranthData);
    return guruGranth.data;
  }

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
              SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: 20,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/book.png",
                    // scale: 6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.GURUGRANTH);
                    },
                    child: Container(
                      height: 45,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).colorScheme.primary),
                      child: const Center(
                        child: Text(
                          "Sundar Gutka",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                              Get.toNamed(Routes.BOOKSLANG);
                            },
                            child: Container(
                              height: 45,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Theme.of(context).colorScheme.primary),
                              child: const Center(
                                child: Text(
                                  "Books",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFF3D3D3D)),
                            child: Image.asset("assets/icons/reading.png"),
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
                              Get.toNamed(Routes.AUDIO);
                            },
                            child: Container(
                              height: 45,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Theme.of(context).colorScheme.primary),
                              child: const Center(
                                child: Text(
                                  "Audio",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFF3D3D3D)),
                            child: Image.asset("assets/icons/audio.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
