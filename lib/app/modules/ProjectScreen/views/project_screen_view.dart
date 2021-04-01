import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/PaymentsScreen/views/payments_screen_view.dart';
import 'package:trko_official/app/modules/UpdatesScreen/views/updates_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';

import '../../../utils/responsive.dart';
import '../../../utils/helper.dart';
import '../controllers/project_screen_controller.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext project_screen_context) {

    ProjectScreenController controller = Get.put(ProjectScreenController());

    controller.title = Get.arguments["title"];
    controller.startDate = Get.arguments["startDate"];
    controller.description = Get.arguments["description"];
    controller.projectId = Get.arguments["projectId"];
    controller.clientId = Get.arguments["clientId"];
    controller.budget = Get.arguments["budget"];

    LoginScreenController loginScreenController = Get.find();

    print("${controller.projectId}");

    return MediaQuery(
      data: myTextScaleFactor(project_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: controller.title,),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
          actions: [

            // first icon button
            Visibility(
              visible: loginScreenController.group_id == controller.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/phone-call svg.svg', onTap: (){  Launch.call();  }, rightMargin: 26.0,
                )
              ),

            // second icon button
            Visibility(
              visible: loginScreenController.group_id == controller.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/whatsapp svg.svg', onTap: () {  Launch.whatsApp();  }, rightMargin: 13.0,
                )
              ),

          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [

                  // top section
                  Container(
                    padding: EdgeInsets.only(left: width(10.0), right: width(10.0), top: height(12.0), bottom: height(19.0)),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        // date
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(controller.convertToDate(dateTime: controller.startDate), style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_gray, fontWeight: FontWeight.bold),),
                        ),

                        // details
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: height(7.0)),
                          child: Text( controller.convertDescription(description: controller.description),
                            style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_gray,),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // bottom section
                  Container(
                    padding: EdgeInsets.only(left: width(10.0), right: width(10.0), top: height(39.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // updates option
                        CardTemplate2(name: 'Updates', icon: 'assets/svg/updated icon svg format.svg', onTap: (){  Get.to(UpdatesScreen(),
                            arguments: {"projectId": controller.projectId, "projectName": controller.title, "clientId": controller.clientId});  },),

                        SizedBox(width: width(41.0),),

                        // payments option
                        CardTemplate2(name: 'Payments', icon: 'assets/svg/credit-card svg sample.svg', onTap: (){ Get.to(PaymentsScreen(),
                            arguments: {"projectId": controller.projectId,
                              "projectName": controller.title, "clientId": controller.clientId, "budget": controller.budget});  },),

                      ],
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
