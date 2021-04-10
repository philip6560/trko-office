import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:trko_official/app/modules/ChangePasswordScreen/views/change_password_screen_view.dart';
import '../utils/responsive.dart';
import '../utils/helper.dart';




loading({BuildContext context}){
  return showDialog(
    barrierDismissible: false,
    context: context, 
    child: Container(
      alignment: Alignment.center,
      child:
        Container(
          width: 160.0,
          height: 200.0,
          child: Lottie.asset("assets/dark_blue.json",)),
    ),
  );
}


// dialog shown when the change password FAB button is clicked on the home screen
changePassword({BuildContext context}){

    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 
  return showDialog(
      barrierDismissible: true,
      context: context,
      child: Container(
        alignment: Alignment.center,
        child:
        GestureDetector(
          onTap: ()async{
            Get.back();
            await Storage.write(key: "navBack", value: "true");
            Get.to(ChangePasswordScreen(),);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height(5.0)),
            ),
            child: Container(
              height: height(70.0),
              width: width(185.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height(5.0)),
              ),
                child: Text("Change password", style: GoogleFonts.poppins(fontSize: height(17.0), color: Colors.black)),
          ),
      ),
        ),
    )
  );
}


class Loading extends StatelessWidget {

  final bool isFullScreen;

  const Loading({this.isFullScreen});

  @override
  Widget build(BuildContext context) {

  height(double value)=> scale_height(value, context); 

    return Center(
      child: Container(
        margin: EdgeInsets.only(top:isFullScreen == false? height(160.0) : height(250.0)),
        width: 160.0,
        height: 200.0,
        child: Lottie.asset("assets/dark_blue.json",),
      ),
    );
  }
}


class RefreshScreen extends StatelessWidget {

  final String label, message;
  final int statusCode;
  final Function onTap;
  final bool isFullScreen;

  var refresh = false.obs;

  RefreshScreen({Key key, this.statusCode, this.message, this.isFullScreen, this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String errorCode = statusCode == null ? message : message + ": " + statusCode.toString();

    height(double value)=> scale_height(value, context);

    return Obx(()=>
            Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              refresh.value== false
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: isFullScreen == false ? height(145.0) : height(250.0),),
                Icon(Icons.error, size: height(90.0), color: MyColor.dark_blue,),
                SizedBox(height: height(8.0),),
                Text( errorCode, style: GoogleFonts.poppins(fontSize: height(16.0),), textAlign: TextAlign.center,),
              ],): Loading(isFullScreen: isFullScreen,),

                SizedBox(height: refresh.value == false? height(24.0): height(20.0),),
                Visibility(
                  visible: refresh.value == true? false : true,
                  child: RaisedButton(
                    color: MyColor.dark_blue,
                    padding: EdgeInsets.symmetric(vertical: height(1.4)),
                    onPressed: (){
                      refresh.value = true;
                      onTap();
                    },
                      child: Text(label, style: TextStyle(fontSize: height(16.0), color: Colors.white)),
            ),
                )
          ]
        ),
      ),
    );
  }
}



confirmationDialog({String onConfirm_label, String onCancel_label, String title, Function onConfirm, Function onCancel}){

  return Get.defaultDialog(
    radius: 5.0,
    title: '\n  Do you want to permanently $title?',
    middleText: '',
    actions: [
      RaisedButton(
        color: Colors.white,
        onPressed: onConfirm,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: MyColor.dark_blue, width: scale_height(1.2, Get.context))),
        child: Text(
          onConfirm_label, style: TextStyle(color: MyColor.dark_blue),
          )
        ),
      SizedBox(width: scale_width(20.0, Get.context),),
      RaisedButton(
        color: MyColor.dark_blue, 
        onPressed: onCancel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Text(onCancel_label, style: TextStyle(color: Colors.white),)
        ),
    ],
  );
}

