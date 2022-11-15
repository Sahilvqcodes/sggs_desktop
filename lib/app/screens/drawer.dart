import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? userName;
  @override
  void initState() {
    super.initState();
    userNameFunction();
  }

  userNameFunction() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString("userName");
    });

    print("userName $userName");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            SizedBox(
              height: 190,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 35,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userName ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: 1.01,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.remove("token");
                              sharedPreferences.remove("userId");
                              sharedPreferences.remove("userName");
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: const Text(
                              "Log Out",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),
            // ListTile(
            //   title: const Text(
            //     'Home',
            //     style: TextStyle(
            //         color: Color(0xFF3D3D3D),
            //         fontSize: 16,
            //         fontWeight: FontWeight.w400),
            //   ),
            //   onTap: () {
            //     Get.offAndToNamed(Routes.HOMEPAGE);
            //   },
            // ),
            ListTile(
              title: const Text(
                'Sri Guru Granth Sahib Ji',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Get.back();
                Get.offAndToNamed(Routes.HOMEPAGE);
              },
            ),
            ListTile(
              title: const Text(
                'Sundar Gutka',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.SUNDARGUTKA);
              },
            ),
            // ListTile(
            //   title: const Text(
            //     'Multi-View',
            //     style: TextStyle(
            //         color: Color(0xFF3D3D3D),
            //         fontSize: 16,
            //         fontWeight: FontWeight.w400),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   title: const Text(
            //     'Bani Controller',
            //     style: TextStyle(
            //         color: Color(0xFF3D3D3D),
            //         fontSize: 16,
            //         fontWeight: FontWeight.w400),
            //   ),
            //   onTap: () {
            //     Get.back();
            //     Get.toNamed(Routes.BANICONTROLLER);
            //   },
            // ),
            ListTile(
              title: const Text(
                'Contact Us',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.CONTACTUS);
              },
            ),
          ],
        ),
      ),
    );
  }
}
