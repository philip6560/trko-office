import 'dart:math';
import 'package:flutter/material.dart';

double scale_width(double value, BuildContext context){

  // width of the screen the design was made on
  double width = MediaQuery.of(context).orientation == Orientation.portrait ? 393.0 : 799.0;

  double width_of_device = MediaQuery.of(context).size.width.floorToDouble();
  double safe_area_horizontal = MediaQuery.of(context).padding.left.floorToDouble() + MediaQuery.of(context).padding.right.floorToDouble();
  // the input value divided by screen width from the design template is then multiplied to
  // give the width based on different screen size
  double actual_width_based_on_screensize = (value/width) * (width_of_device - safe_area_horizontal);
  // convert width to two decimal places
  double mod = pow(10.0, 4);
  double final_width = ((actual_width_based_on_screensize * mod).round().toDouble() / mod);
  return final_width;
  
}


double scale_height(double value, BuildContext context){

  // height of the screen the design was made on
  double height = MediaQuery.of(context).orientation == Orientation.portrait ? 799.0 : 393.0;

  double height_of_device = MediaQuery.of(context).size.height.floorToDouble();
  double safe_area_vertical =  MediaQuery.of(context).padding.top.floorToDouble() + MediaQuery.of(context).padding.bottom.floorToDouble() + AppBar().preferredSize.height.floorToDouble();
  // the input value divided by screen width from the design template is then multiplied to
  // give the width based on different screen size
  double actual_height_based_on_screensize = (value/height) * (height_of_device - safe_area_vertical);
  // convert width to two decimal places
  double mod = pow(10.0, 4);
  double final_height = ((actual_height_based_on_screensize * mod).round().toDouble() / mod);
  return final_height;

}
