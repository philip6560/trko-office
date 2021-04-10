
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';


class AppbarButton extends StatelessWidget {

  final String icon;
  final Function onTap;
  final double rightMargin;

  const AppbarButton({Key key, this.icon, this.onTap, this.rightMargin}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    width(double value)=> scale_height(value, context); 

    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: EdgeInsets.only(right: width(this.rightMargin)),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}



class NavbackButton extends StatelessWidget {

  static double leading_width = scale_height(53.0, Get.context);  // check its responsiveness
  static double titlespacing = 0.0;
  final Function onTap;
  
  NavbackButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    return GestureDetector(
      onTap: this.onTap == null ? () {  Get.back();  } : this.onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: width(10.0),),
        child: Icon(CupertinoIcons.chevron_back, size: height(32.0),),
      ),
    );
  }
}




class ScreenName extends StatelessWidget {
  final String screen_name;
  ScreenName({Key key, this.screen_name}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(top: scale_height(4.0, context)),
    alignment: Alignment.centerLeft,
      child: Text(this.screen_name, style: GoogleFonts.poppins(fontSize: scale_height(18.0, context)), overflow: TextOverflow.ellipsis,)
  );
}