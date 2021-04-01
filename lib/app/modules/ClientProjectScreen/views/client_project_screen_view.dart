import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/ClientProjectScreen/controllers/client_project_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';

class ClientProjectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext client_project_screen_context) {

    ClientProjectScreenController controller = Get.put(ClientProjectScreenController());
    
    return MediaQuery(
      data: myTextScaleFactor(client_project_screen_context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.dark_blue,
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: "Client's Project",),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(height: height(31.0),),
              //
              // CardTemplate1(
              //   title: "Project XYZ and YZ", projectstatus: MyColor.strong_orange,
              // ),
              //
              // SizedBox(height: height(21.0),),
              //
              // CardTemplate1(
              //     title: "Project XYZ and YZ", projectstatus: MyColor.dark_cyan,
              // ),
              //
              // SizedBox(height: height(21.0),),
              //
              // CardTemplate1(
              //     title: "Project XYZ and YZ", projectstatus: MyColor.dark_cyan,
              // ),
            ],
          ), 
        ),
      ),
    );
  }
}
  