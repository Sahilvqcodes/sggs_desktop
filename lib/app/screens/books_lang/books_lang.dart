import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/books_model.dart';
import '../../models/guru_granth_data.dart';
import '../drawer.dart';
import '../multi_view_drawer.dart';
import '../../widgets/multiselect_lang.dart';
import 'package:http/http.dart' as http;

class BooksDetails extends StatefulWidget {
  BooksDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<BooksDetails> createState() => _BooksDetailsState();
}

class _BooksDetailsState extends State<BooksDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String dropdownValue = 'Translations';
  late bool isDrawer;
  bool? isMultiviewDrawer;
  bool value = false;
  bool buttonenabled = false;
  int i = 1;
  String? userId;
  List<Book>? _bookDetails;
  void initState() {
    isDrawer = false;
    isMultiviewDrawer = false;
    super.initState();
    // print(Get.arguments);
    _bookDetails = Get.arguments;

    // i = Get.arguments ?? 1;
  }

  List<String> _selectedItems = [
    'English',
  ];
  void _showMultiSelect() async {
    final List<String> items = [
      'English',
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

    if (results != null) {
      setState(() {
        _selectedItems = results;
        print(_selectedItems);
      });
    }
  }

  String? bookName;

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
    return guruGranth.data;
  }

  _launchURLBrowser(String? bookLink) async {
    var url = Uri.parse(bookLink!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                        decoration: BoxDecoration(
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
                            decoration: BoxDecoration(
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
              //   height: 50,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 25, bottom: 30),
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${_bookDetails![0].language} Language",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
              ),
              Container(
                // height: 500,
                padding: EdgeInsets.only(left: 15),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _bookDetails!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _bookDetails![index].bookName ?? "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.01),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _launchURLBrowser(
                                      _bookDetails![index].bookLink);
                                },
                                child: Icon(
                                  Icons.download,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 0.8,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
