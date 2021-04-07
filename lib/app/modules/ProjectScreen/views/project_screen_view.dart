import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/PaymentsScreen/views/payments_screen_view.dart';
import 'package:trko_official/app/modules/UpdatesScreen/views/updates_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';

import '../../../models/user_model.dart';
import '../../../utils/responsive.dart';
import '../../../utils/helper.dart';
import '../controllers/project_screen_controller.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext project_screen_context) {

    ProjectScreenController controller = Get.put(ProjectScreenController(),);

    HomeScreenController homeScreenController = Get.find();

    print("ProjectName ${homeScreenController.projectName} ProjectID ${homeScreenController.projectId} and CLIENTID ooo ${homeScreenController.clientId}");

    return MediaQuery(
      data: myTextScaleFactor(project_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(onTap: (){   Get.back(closeOverlays: true);   },),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: homeScreenController.projectName,),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
          actions: [

            // first icon button
            Visibility(
              visible: homeScreenController.groupId == User.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/phone-call svg.svg', onTap: (){  Launch.call();  }, rightMargin: 26.0,
                )
              ),

            // second icon button
            Visibility(
              visible: homeScreenController.groupId == User.client ? true : false,
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
                          child: Text(
                            controller.convertToDate(dateTime: homeScreenController.startDate), 
                            style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_gray, fontWeight: FontWeight.bold),),
                        ),

                        // details
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: height(7.0)),
                          child: Text( controller.convertDescription(description: homeScreenController.description),
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
                        CardTemplate2(
                          key: ValueKey("Updates"),
                          name: 'Updates', icon: 'assets/svg/updated icon svg format.svg', onTap: (){  Get.to(UpdatesScreen(),);  },),

                        SizedBox(width: width(41.0),),

                        // payments option
                        CardTemplate2(
                          key: ValueKey("Payments"),
                          name: 'Payments', icon: 'assets/svg/credit-card svg sample.svg', onTap: (){ Get.to(PaymentsScreen());  },),

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
