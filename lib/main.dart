import 'package:flutter/material.dart';

import 'package:get/get.dart';

import './app/routes/app_pages.dart';
import './app/utils/helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Trko",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: MyColor.dark_blue,
        scaffoldBackgroundColor: MyColor.light_grayish_red,
        appBarTheme: AppBarTheme(
          elevation: 0,

        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
