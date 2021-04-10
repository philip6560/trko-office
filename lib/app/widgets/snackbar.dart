import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../utils/helper.dart';


snackbarResponse(String message){
  return Get.snackbar(
          '',
          '',
          messageText: Text('$message', style: GoogleFonts.poppins(fontSize: scale_height(16.0, Get.context), color: Colors.white,)),
          backgroundColor: MyColor.dark_cyan,
          duration: Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.only(bottom: 5.0, top:0.0, left: 19.0, right: 5.0),
          borderRadius: 0.0,
        );
}