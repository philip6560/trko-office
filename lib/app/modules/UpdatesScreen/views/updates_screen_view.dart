import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/modules/AddUpdateScreen/views/add_update_screen_view.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';

import '../../../utils/helper.dart';
import '../controllers/updates_screen_controller.dart';

class UpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext updates_screen_context) {

    UpdatesScreenController controller = Get.put(UpdatesScreenController());

    controller.projectId = Get.arguments["projectId"];
    controller.projectName = Get.arguments["projectName"];
    controller.clientId = Get.arguments["clientId"];

    LoginScreenController loginScreenController = Get.find();

    print("Clienttttdddsd: ${controller.clientId}");

    return MediaQuery(
      data: myTextScaleFactor(updates_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: "Updates",),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
          actions: [

            // first icon button
            Visibility(
              visible: loginScreenController.group_id == controller.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/phone-call svg.svg', onTap: (){ Launch.call(); }, rightMargin: 26.0,
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
            child: Obx(()=>
              Container(
                padding: EdgeInsets.only(left: width(10.0), top: height(20.0), right: width(10.0)),
                child: Column(
                  children: [

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: width(7.0),),
                      child: Text(
                        controller.projectName,
                        style: GoogleFonts.poppins(fontSize: height(18.0), fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: height(40.0), ),

                    // Futurebuilder in conjuction with list view builder are to be utilized for the results.
                    // search results
                    controller.updatesList.isEmpty? Loading()
                    : controller.updatesList[0].description != null && controller.updatesList[0].updateId == null
                    ? refreshProjectScreen(message: controller.updatesList[0].description, label: "refresh", statusCode: null)
                    : controller.updatesList[0].updateId == null
                    ? Container(
                      margin: EdgeInsets.only(top: height(270.0)),
                        alignment: Alignment.center,
                        child: Text("You do not have any update.", style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_blue,)),
                    )
                    :ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.updatesList.length,
                      itemBuilder: (context,index){
                        Update update = controller.updatesList[index];// check clientId is gotten
                        return Visibility(
                          visible: controller.showUpdate(loginScreenController.group_id, update.isApproved),
                          child: Column(
                            children: [
                              CardTemplate4(
                                key: ValueKey(update.updateId),
                                isApproved: update.isApproved,
                                createdAt: controller.convertDateTime(update.createdAt),
                                description: update.description,
                                milestone: update.milestone,
                                link1: update.link1,
                                link2: update.link2,
                                link3: update.link3,
                                updateId: update.updateId,
                              ),
                              Visibility(
                                  visible: (controller.updatesList.length - 1) == index ? false : true,
                                  child: CardConnector()
                              ),
                            ],
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        floatingActionButton: Obx(()=>
          Visibility(
             visible: controller.is_button_visible.value == true
                 && controller.admin == loginScreenController.group_id ? true : false,
            child: FloatingActionButton(
              backgroundColor: MyColor.dark_cyan,
              onPressed: (){   Get.to(AddUpdateScreen());   },
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
