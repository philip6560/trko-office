 import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trko_official/app/modules/SplashScreen/views/splash_screen_view.dart';

import './app/routes/app_pages.dart';
import './app/utils/helper.dart';

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
      builder: (BuildContext context, Widget child){
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
            data: data.copyWith(textScaleFactor: data.textScaleFactor.clamp(0.85, 1.0)),
            child: child,
        );
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
