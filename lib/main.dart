/*
 * File name: main.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
// import 'package:window_size/window_size.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  //2
  await windowManager.setMinimumSize(const Size(512, 575));

  runApp(
    GetMaterialApp(
      title: "",
      initialRoute: Theme1AppPages.INITIAL,
      getPages: Theme1AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFE9F33),
          // secondary: const Color(0xFFFFC107),
        ),
      ),
    ),
  );
}
