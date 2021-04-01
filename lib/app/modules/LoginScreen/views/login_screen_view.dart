import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/text_fields.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext login_screen_context) {

    LoginScreenController controller = Get.put(LoginScreenController(), permanent: true);

    return MediaQuery(
      data: myTextScaleFactor(login_screen_context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: height(83.0), left: width(10.0), right: width(10.0)),
            child: Obx(()=>
               Form(
                key: controller.formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // image
                    Container(
                      padding: EdgeInsets.only(bottom: height(16.0), right: width(40.0)),
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset('assets/svg/login.svg'),
                    ),

                    // text 1
                    Container(
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: height(30.0), fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: height(14.0),),

                    // text 2
                    Container(
                      child: Text(
                        'Please Enter Details to continue',
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: height(18.0), fontWeight: FontWeight.normal),
                      )
                    ),

                    SizedBox(height: height(31.0),),

                    // email field label
                    FieldLabel(
                      labelname: 'Email',
                    ),

                    SizedBox(height: height(13.0),),

                    // email field
                    MyFormField(
                      fieldKey: controller.field1,
                      textEditingController: controller.emailcontroller,
                      textInputAction: TextInputAction.next,
                      validator: (String val)=> val.isNotEmpty && GetUtils.isEmail(val)? null: "Invalid email address",
                      onSaved: (String val)=> controller.email = val.obs,
                    ),

                    SizedBox(height: height(25.0),),

                    // password field label
                    FieldLabel(
                      labelname: 'Password',
                    ),

                    SizedBox(height: height(13.0),),

                    // password field
                    MyFormField(
                      fieldKey: controller.field2,
                      textEditingController: controller.passwordcontroller,
                      textInputAction: TextInputAction.done,
                      validator: (String val)=> val.isNotEmpty ? null: "Enter password",
                      onSaved: (String val)=> controller.password = val.obs,
                      obscureText: true,
                    ),

                    SizedBox(height: height(52.0),),

                    // login button
                    Center(
                      child: PrimaryButton(
                        label: "Login", margin: EdgeInsets.symmetric(horizontal: width(24.0)), onPressed: (){ controller.validate(); },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
  