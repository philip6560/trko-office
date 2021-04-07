//Define your text fields here
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../utils/helper.dart';


class MyFormField extends StatelessWidget {

  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function validator;
  final Function onSaved;
  final ValueKey fieldKey;
  final bool obscureText;
  final Function onChanged;


  MyFormField({Key key, this.fieldKey, this.textEditingController,this.onChanged, this.textInputType,
    this.textInputAction, this.validator, this.onSaved, this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height(56.0),
      child: TextFormField(
        autofocus: false,
        obscureText: this.obscureText == null? false : this.obscureText,
        cursorColor: MyColor.dark_blue,
        keyboardType: this.textInputType == null ? TextInputType.text : this.textInputType,
        textInputAction: this.textInputAction,
        controller: this.textEditingController,
        validator: this.validator,
        onSaved: this.onSaved,
        onChanged: this.onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: height(20.30), horizontal: width(26.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height(28.0)),
            borderSide: BorderSide(color: MyColor.formfield_border, width: 0.0),
          ), 
        ),
      ),
    );
  }
}


class FieldLabel  extends StatelessWidget {

  final String labelname;

  FieldLabel ({Key key, this.labelname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: width(26.0)),
      child: Text(
        this.labelname,
        style: GoogleFonts.poppins(color: MyColor.formfield_label, fontSize: height(15.0), ),
      ),
    );
  }
}



class DescriptionField extends StatelessWidget {

  final TextEditingController textEditingController;
  final ValueKey fieldKey;
  final Function validator;
  final Function onSaved;
  
  DescriptionField({Key key, this.fieldKey, this.textEditingController, this.validator, this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(373.0),
      height: height(287.0),
      child: TextFormField(
        autofocus: false,
        maxLines: 30,
        cursorColor: MyColor.dark_blue,
        controller: this.textEditingController,
        validator: this.validator,
        onSaved: this.onSaved,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: height(18.0), horizontal: width(26.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height(28.0)),
            borderSide: BorderSide(color: MyColor.formfield_border),
          ),
        ),
      ),
    );
  }
}