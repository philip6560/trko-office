import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/change_password_screen_controller.dart';

class ChangePasswordScreen extends  StatelessWidget {
  @override
  Widget build(BuildContext change_password_screen_context) {

    ChangePasswordScreenController controller = Get.put(ChangePasswordScreenController());

    // controller.group_id = Get.arguments["group_id"];
    // controller.token = Get.arguments["token"];

    LoginScreenController loginScreenController = Get.find();

    controller.navBackButton = Get.arguments["navback"];


    // print("token: ${controller.token}");


    return MediaQuery(
      data: myTextScaleFactor(change_password_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: Visibility(
            visible: controller.navBackButton,
            child: NavbackButton()
            ),
          leadingWidth: controller.navBackButton == false ? 0.0 : NavbackButton.leading_width,
          title: ScreenName(screen_name: "Change Password"),
          titleSpacing: controller.navBackButton == false ? width(10.0) : NavbackButton.titlespacing,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: height(25.0), left: width(10.0), right: width(10.0),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height(32.0),),

                  // amount field label
                  FieldLabel(
                    labelname: 'Old Password',
                  ),

                  SizedBox(height: height(13.0),),

                  // amount field
                  MyFormField(
                    fieldKey: controller.field1,
                  ),

                  SizedBox(height: height(26.0),),

                  // date field label
                  FieldLabel(
                    labelname: 'New Password',
                  ),

                  SizedBox(height: height(12.0),),

                  // date field
                  MyFormField(
                    fieldKey: controller.field2,
                  ),

                  SizedBox(height: height(26.0),),

                  // note field label
                  FieldLabel(
                    labelname: 'Retype Password',
                  ),

                  SizedBox(height: height(12.0),),

                  // note field
                  MyFormField(
                    fieldKey: controller.field3,
                  ),

                  SizedBox(height: height(46.0),),

                  // save button
                  Center(
                    child: PrimaryButton(
                      label: "Save", margin: EdgeInsets.only(left: width(54.0), right: width(40.0),), onPressed: (){ controller.changePassword();  },
                    )
                  ),
                ],     
              ),
            ),
          ),
        ),
      ),
    );
  }
}
