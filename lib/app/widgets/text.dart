import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/utils/responsive.dart';

// Project title

class ProjectName extends StatelessWidget {

  final String projectName;

  const ProjectName({Key key, this.projectName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    height(double value)=> scale_height(value, context);

    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        this.projectName,
        style: GoogleFonts.poppins(color: Colors.black, fontSize: height(18.0), fontWeight: FontWeight.w700),
      )
    );
  }
}

