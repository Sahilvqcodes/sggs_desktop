import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/local_sggs.dart';
import 'package:gurugranth_app/app/models/multiview_model.dart';
import 'package:gurugranth_app/app/screens/guru_granth_sahib.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../routes/app_routes.dart';

class MultiviewDrawer extends StatefulWidget {
  const MultiviewDrawer({super.key});

  @override
  State<MultiviewDrawer> createState() => _MultiviewDrawerState();
}

class _MultiviewDrawerState extends State<MultiviewDrawer> {
  // List<AddedMultiview>? _multiviewData;
  // getMultiviewData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? userId = sharedPreferences.getString("userId");
  //   print(userId);
  //   String url = 'http://143.244.139.23:94/api/get_multiview?user_id=$userId';
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   String json = response.body;
  //   var multiview = MultiviewData.fromJson(jsonDecode(response.body));
  //   _multiviewData = multiview.data;
  //   // print(_multiviewData);
  //   return _multiviewData;
  // }
  getMultiviewData() async {
    final prefs = await SharedPreferences.getInstance();
    var _multiviewData = prefs.getStringList("multiview")!;
    print("_multiviewData1 ${_multiviewData}");
    List<AngData> _angList = [];
    _multiviewData.forEach((element) {
      Map<String, dynamic> map = jsonDecode(element);
      print("map $map");
      AngData _angData = AngData.fromJson(map);
      _angList.add(_angData);
    });
    print("_multiviewData2 ${_angList}");
    return _angList;
  }

  removeMultiview(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> _removeMultiview = prefs.getStringList("multiview")!;
    if (_removeMultiview != null) {
      _removeMultiview.removeAt(0);
      print("_removeMultiview $_removeMultiview");
      // prefs.setString("multiview", _removeMultiview)
      await prefs.remove("multiview");
      await prefs.setStringList("multiview", _removeMultiview);
      setState(() {});
    } else {
      print('favoriteList was null');
    }
  }

  // removeMultiview(String? id) async {
  //   print("remove $id");
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? userId = sharedPreferences.getString("userId");

  //   final http.Response res = await http.post(
  //     Uri.parse('http://143.244.139.23:94/api/multiviewdelete/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       // 'name': user.name,
  //       'user_id': userId ?? "",
  //     }),
  //   );
  //   String json = res.body;
  //   if (res.statusCode == 200) {
  //     print("Response $json");
  //     setState(() {});
  //   } else {
  //     print("error");
  //   }
  // }
  clearAllMultiview() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> _blankMulti = [];
    prefs.remove("multiview");
    prefs.setStringList("multiview", _blankMulti);
    setState(() {});
  }

  // clearAllMultiview() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? userId = sharedPreferences.getString("userId");

  //   final http.Response res = await http.post(
  //     Uri.parse('http://143.244.139.23:94/api/clearall'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       // 'name': user.name,
  //       'user_id': userId ?? "",
  //     }),
  //   );
  //   String json = res.body;
  //   if (res.statusCode == 200) {
  //     print("Response $json");
  //     setState(() {});
  //   } else {
  //     print("error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Container(
      padding: EdgeInsets.zero,
      width: size.width * 0.7,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: size.width > 500 ? 110 : 170,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: DrawerHeader(
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                // ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: [
                          Text(
                            "Multi-View",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.0018,
            ),
            Container(
              height: size.height * 0.84,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                ),
                child: Column(
                  children: [
                    const Text(
                      'View multiple Shabads on one page. Search for a Shabad and click the + icon next to the search result or at the top of any Shabad page. Once added, click the "display" button in this panel to show your custom page of Shabads.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    FutureBuilder(
                        future: getMultiviewData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          // print("_multiviewData $_multiviewData");
                          print("snapshot.data ${snapshot.data} ");
                          List<AngData>? multiviewData = snapshot.data;
                          // print(multiviewData[0].ang);

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (multiviewData?.length == 0) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.height * 0.06),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: size.width * 0.45,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "Multiview Not Found",
                                              style: const TextStyle(
                                                color: Color(0xFF3D3D3D),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20),
                                    height: 40,
                                    width: size.width * 0.095,
                                    decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10.0),
                                        color: Color(0xFF3D3D3D)),
                                    child: InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Container(
                            height: size.height * 0.55,
                            child: Column(
                              children: [
                                Container(
                                  height: size.width > 500 && size.height < 420
                                      ? size.height * 0.3
                                      : size.height * 0.47,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: multiviewData!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                // height: 37,
                                                width: size.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.0),
                                                    color: Colors.white),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            GuruGranthSahib(
                                                          ang: int.parse(
                                                              multiviewData[
                                                                          index]
                                                                      .ang ??
                                                                  ""),
                                                          id: int.parse(
                                                              multiviewData[
                                                                          index]
                                                                      .id ??
                                                                  ""),
                                                        ),
                                                      ),
                                                    );
                                                    // Get.toNamed(
                                                    //     Routes.GURUGRANTH,
                                                    //     arguments: int.parse(
                                                    //         _multiviewData?[
                                                    //                     index]
                                                    //                 .ang ??
                                                    //             ""));
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "${multiviewData[index].name}",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF3D3D3D),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                // margin: EdgeInsets.only(left: 20),
                                                height: 38,
                                                width: size.width * 0.095,
                                                decoration: const BoxDecoration(
                                                    // borderRadius: BorderRadius.circular(10.0),
                                                    color: Color(0xFF3D3D3D)),
                                                child: InkWell(
                                                  onTap: () {
                                                    removeMultiview(index);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 38,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: size.width * 0.22,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF3D3D3D),
                                            foregroundColor: Colors.white),
                                        onPressed: () {
                                          clearAllMultiview();
                                        },
                                        child: Text("Clear"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    // Container(
                                    //   width: size.width * 0.22,
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //         backgroundColor: Colors.white,
                                    //         foregroundColor: Color(0xFF3D3D3D)),
                                    //     onPressed: () {},
                                    //     child: const Text("Display"),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    // SizedBox(
                    //   height: size.height * 0.005,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
