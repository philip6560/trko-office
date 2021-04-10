//ADD YOUR PRIMARY BUTTON


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../utils/helper.dart';

class PrimaryButton extends StatelessWidget {

  final EdgeInsetsGeometry margin;
  final Function onPressed;
  final String label;

  PrimaryButton({Key key, this.label, this.margin, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    return Container(
      width: width(299.0),
      height: height(56.0),
      margin: this.margin, // check this out
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height(28.0)),
        ),
        color: MyColor.dark_cyan,
        onPressed: this.onPressed,
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: height(18.0), color: Colors.white,),
        ),
      ),
    );
  }
}









//ADD YOUR SECONDARY BUTTON HERE