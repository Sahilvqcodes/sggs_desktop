import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/guru_granth_data.dart';
import 'package:gurugranth_app/app/models/line_model.dart';
import 'package:gurugranth_app/app/models/local_sggs.dart';
import 'package:gurugranth_app/app/screens/Drawer.dart';
import 'package:gurugranth_app/app/screens/multi_view_drawer.dart';
import 'package:gurugranth_app/app/utilities/sggs_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;

import '../widgets/multiselect_lang.dart';

// List<String> list = <String>['car', 'Train', 'Bus', 'Flight'];

class GuruGranthSahib extends StatefulWidget {
  const GuruGranthSahib({
    Key? key,
    this.id,
  }) : super(key: key);
  final int? id;
  @override
  State<GuruGranthSahib> createState() => _GuruGranthSahibState();
}

class _GuruGranthSahibState extends State<GuruGranthSahib> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // GoogleTranslator translator = GoogleTranslator();
  // LanguageModel? _choosenValue;
  // List<LanguageModel> _languages = List.empty(growable: true);
  // final ScrollController _controller = ScrollController();
  AutoScrollController? controller;
  final scrollDirection = Axis.vertical;
  // String dropdownValue = list.first;
  String dropdownValue = 'Translations';
  late bool isDrawer;
  bool? isMultiviewDrawer;
  bool value = false;
  int i = 1;

  bool buttonenabled = false;

  String line_no = "";
  String? userId;
  bool? fullView;
  void initState() {
    isDrawer = false;
    isMultiviewDrawer = false;
    fullView = false;
    super.initState();
    // print(Get.arguments);
    var data = Get.arguments;
    // setState(() {
    if (widget.id == null) {
      i = data?[0] ?? 1;
    } else {
      i = widget.id ?? 1;
    }

    if (Get.arguments != null) {
      scrollData(data[1]);
    }
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);

    // });
    //
    // _languages.add(LanguageModel(code: 'en', name: 'English'));
    // _languages.add(LanguageModel(code: 'hin', name: 'Hindi'));
    // _languages.add(LanguageModel(code: 'ar', name: 'Arabic'));
    // _languages.add(LanguageModel(code: 'gu', name: 'Gujarati'));

    // translations();
    // getUserId();
  }

  _scrollToIndex(int sr_no) async {
    await controller!
        .scrollToIndex(sr_no, preferPosition: AutoScrollPosition.begin);
    print("_scrollToIndex11");

    // _scrollToIndex(sr_No);
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

    // print(guruGranthData);
    // guruGranth.data!.length == 0 ? print("cj bnjk") : print("cdbhjbvhcd");
    if (guruGranth.data!.length != 0) {
      // print("guruGranthData $guruGranthData");
      guruGranthData = guruGranth.data;
    } else {
      setState(() {
        i = 1;
      });
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.error,
          text: "Ang Is Not Available",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }

    return guruGranth.data;
  }

  LineData? _dataLine;
  int sr_No = 1;
  // getLineNo(String line_no) async {
  //   String url = 'http://143.244.139.23:94/api/line?id=$line_no';
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   String json = response.body;
  //   var _lineData = LineData.fromJson(jsonDecode(response.body));
  //   _dataLine = _lineData;
  //   // print("_dataLine?.ang ${_dataLine?.data?.ang}");
  //   // print(guruGranthData);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       i = int.parse(_dataLine?.data?.ang ?? "");
  //       sr_No = _dataLine?.count ?? 1;
  //       sr_No -= 1;
  //     });
  //   } else if (response.statusCode == 401) {
  //     CoolAlert.show(
  //         width: 50,
  //         context: context,
  //         type: CoolAlertType.error,
  //         text: "Line No Is Not Available",
  //         confirmBtnColor: Theme.of(context).colorScheme.primary);
  //   }

  //   return _dataLine;
  // }

  // final double _height = 100;
  // // final contentSize = _controller.position.viewportDimension + _controller.position.maxScrollExtent;

  // _animateToIndex(int index) {
  //   _controller.position.animateTo(
  //     index * _height,
  //     duration: Duration(seconds: 2),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }
  // List of items in our dropdown menu
  getLineNo(String line_no) async {
    List<AngData> data = await SggsHandler.getLineNo(context, line_no);
    print("data $data");
    var indexData;
    data.forEach((element) {
      indexData = data.indexWhere((element) => element.id == "$line_no");
      print("indexData $indexData");
    });
    setState(() {
      i = int.parse(data[0].ang ?? "");
      print("i ${data[0].ang}");
      sr_No = indexData;
      // sr_No -= 1;
    });
  }

  scrollData(data) async {
    await getLineNo("$data");
    await _scrollToIndex(sr_No);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var bookData = Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ang: $i",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              fullView == false
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fullView = true;
                        });
                      },
                      child: Text(
                        "View Full Mode",
                        style: TextStyle(fontSize: 15),
                      ))
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fullView = false;
                        });
                      },
                      child: Text(
                        "Exit Full Mode",
                        style: TextStyle(fontSize: 15),
                      ))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: buttonenabled
                    ? () async {
                        await _scrollToIndex(0);
                        setState(() {
                          i = i - 1;
                          // print("integer ${i}");
                          i == 1 ? buttonenabled = false : buttonenabled = true;
                          line_no = "";
                        });
                      }
                    : null,
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: buttonenabled
                            ? () async {
                                await _scrollToIndex(0);
                                setState(() {
                                  i = i - 1;
                                  // print("integer ${i}");
                                  i == 1
                                      ? buttonenabled = false
                                      : buttonenabled = true;
                                  line_no = "";
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      Text(
                        "Previous",
                        style: const TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "ਸ੍ਰੀ ਗੁਰੂ ਗ੍ਰੰਥ ਸਾਹਿਬ ਜੀ",
                    style: const TextStyle(
                      color: Color(0xFF3D3D3D),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("")
                ],
              ),
              InkWell(
                onTap: () async {
                  await _scrollToIndex(0);
                  setState(() {
                    i = i + 1;
                    print("integer ${i}");
                    i >= 1 ? buttonenabled = true : buttonenabled = false;
                    line_no = "";
                    // print(buttonenabled);
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await _scrollToIndex(0);
                          setState(() {
                            i = i + 1;
                            print("integer ${i}");
                            i >= 1
                                ? buttonenabled = true
                                : buttonenabled = false;
                            line_no = "";

                            // print(buttonenabled);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                      Text(
                        "Next",
                        style: const TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 10.0, top: 10, left: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Line No: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(5),
                      ],
                      key: Key(line_no),
                      // controller: TextEditingController(text: "${i}"),

                      initialValue: line_no,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: ((value) {
                        // setState(() {
                        line_no = value;
                        print("value $value");
                        // });
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await getLineNo(line_no);
                      await _scrollToIndex(sr_No);
                      // await _scrollToIndex1(sr_No);

                      // await _animateToIndex(sr_No);
                      // final contentSize =
                      //     _controller.position.viewportDimension +
                      //         _controller.position.maxScrollExtent;
                      // // final index = 100;
                      // print("sr_No ${sr_No}");
                      // final target =
                      //     contentSize * sr_No / guruGranthData!.length;
                      // _controller.position.animateTo(
                      //   target,
                      //   duration: Duration(seconds: 2),
                      //   curve: Curves.easeInToLinear,
                      // );

                      // i = await int.parse(_dataLine?.ang ?? "");
                      setState(() {
                        // i = i;

                        i == 1 ? buttonenabled = false : buttonenabled = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Ang: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  // Note: Same code is applied for the TextFormField as well
                  Container(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(5),
                      ],
                      textAlign: TextAlign.center,
                      key: Key(i.toString()),
                      // controller: TextEditingController(text: "${i}"),

                      initialValue: i.toString(),

                      keyboardType: TextInputType.number,
                      onChanged: ((value) {
                        // setState(() {
                        i = int.parse(value);
                        print("value $value");
                        // });
                      }),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 65,
                  //   height: 30,
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.black)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 5.0),
                  //     child: TextFormField(
                  //       textAlign: TextAlign.center,
                  //       key: Key(i.toString()),
                  //       // controller: TextEditingController(text: "${i}"),

                  //       initialValue: i.toString(),
                  //       decoration: new InputDecoration(
                  //           //  hintText: "$i"
                  //           ),
                  //       keyboardType: TextInputType.number,
                  //       onChanged: ((value) {
                  //         // setState(() {
                  //         i = int.parse(value);
                  //         print("value $value");
                  //         // });
                  //       }),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await _scrollToIndex(0);
                      setState(() {
                        i >= 1 ? buttonenabled = true : buttonenabled = false;
                        line_no = "";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: fullView == false ? size.height * 0.63 : size.height * 0.75,
          child: FutureBuilder(
            future: SggsHandler.getAllShabad(context, i.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print("Matches ${snapshot.data}");

              List<AngData>? _angData = snapshot.data;
              // print("_data1 ${_angData}");
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                    scrollDirection: scrollDirection,
                    controller: controller,
                    // shrinkWrap: true,
                    children: [
                      ...List.generate(_angData?.length ?? 0, (index) {
                        // itemCount: guruGranthData?.length,
                        // itemBuilder: (context, index) {
                        // print("index $index   ${guruGranthData?[index].id}");
                        sr_No = index + 1;
                        // print(sr_No);
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: controller!,
                          index: index,
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "${_angData?[index].id} .",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _angData?[index].name ?? "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (_selectedItems.contains("English"))
                                  Text(
                                    _angData?[index].english ?? "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xFF3D3D3D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: 1.1),
                                  ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // if (_selectedItems.contains("Hindi"))
                                //   Text(
                                //     _angData[index].hindi ?? "",
                                //     textAlign: TextAlign.center,
                                //     style: const TextStyle(
                                //         color: Color(0xFF001972),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 18,
                                //         letterSpacing: 1.1),
                                //   ),
                                // if (_selectedItems.contains("Arabic"))
                                //   Text(
                                //     guruGranthData?[index].arabic ?? "",
                                //     textAlign: TextAlign.center,
                                //     style: const TextStyle(
                                //         color: Color(0xFF001972),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 18,
                                //         letterSpacing: 1.1),
                                //   ),
                                // if (_selectedItems.contains("Gujarati"))
                                //   Text(
                                //     guruGranthData?[index].gujarati ?? "",
                                //     textAlign: TextAlign.center,
                                //     style: const TextStyle(
                                //         color: Color(0xFF001972),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 18,
                                //         letterSpacing: 1.1),
                                //   ),
                              ],
                            ),
                          ),
                        );
                      })
                    ]
                    // },
                    ),
              );
            },
          ),
        ),
      ],
    );

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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: fullView == false
                ? Column(
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
                                margin:
                                    EdgeInsets.only(left: size.width * 0.03),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    addPage(
                                        guruGranthData?[0].id.toString() ?? "");
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
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.025),
                                    height: 40,
                                    width: size.width * 0.38,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF3D3D3D), //<-- SEE HERE
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      bookData
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      bookData,
                    ],
                  ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(top: 0),
      //   child: FloatingActionButton(
      //     // isExtended: true,
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //       size: 30,
      //     ),
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
    );
  }
}
