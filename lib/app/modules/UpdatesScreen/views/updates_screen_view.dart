import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/modules/AddUpdateScreen/views/add_update_screen_view.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';

import '../../../models/user_model.dart';
import '../../../utils/helper.dart';
import '../controllers/updates_screen_controller.dart';

class UpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    UpdatesScreenController controller = Get.put(UpdatesScreenController(),);

    HomeScreenController homeScreenController = Get.find();

    print("i came to updates screen");

    return Scaffold(
      appBar: AppBar(
        leading: NavbackButton(),
        leadingWidth: NavbackButton.leading_width,
        title: ScreenName(screen_name: "Updates",),
        titleSpacing: NavbackButton.titlespacing,
        centerTitle: false,
        actions: [

          // first icon button
          Visibility(
            visible: homeScreenController.groupId.value == User.client ? true : false,
            child: AppbarButton(
              icon: 'assets/svg/phone-call svg.svg', onTap: (){ Launch.call(); }, rightMargin: 26.0,
              )
            ),

          // second icon button
          Visibility(
            visible: homeScreenController.groupId.value == User.client ? true : false,
            child: AppbarButton(
              icon: 'assets/svg/whatsapp svg.svg', onTap: () {  Launch.whatsApp();  }, rightMargin: 13.0,
              )
            ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: width(10.0), top: height(20.0), right: width(10.0), bottom: height(60.0)),
          child: Obx(()=>
            Column(
              children: [

                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: width(7.0),),
                  child: Text(
                    homeScreenController.projectName,
                    style: GoogleFonts.poppins(fontSize: height(18.0), fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),

                SizedBox(height: height(40.0), ),

                // updates from the api

                controller.updatesList.isEmpty ? // check if update's list is empty

                Loading(isFullScreen: false,) : // else

                // if api call returns error
                controller.updatesList[0].updateId == null && controller.updatesList[0].message != null ?

                RefreshScreen(
                  message: controller.updatesList[0].message,
                  label: "refresh",
                  onTap: (){
                    controller.onReady();
                  },
                  statusCode: controller.updatesList[0].statusCode,
                  isFullScreen: false,
                )

                : // else

                // if project has no updates
                controller.updatesList[0].updateId == null && controller.updatesList[0].description == null ?

                Container(
                  margin: EdgeInsets.only(top: height(270.0)),
                  alignment: Alignment.center,
                  child: Text("You do not have any update.", style: GoogleFonts.poppins(fontSize: height(17.0), color: Colors.black,)),
                )

                : // else

                // project update List were gotten display them
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.updatesList.length,
                  itemBuilder: (context,index){
                    Update update = controller.updatesList[index];// check clientId is gotten
                    return Visibility(
                      visible: controller.showUpdate(homeScreenController.groupId.value, update.isApproved),
                      child: Column(
                        children: [
                          CardTemplate4(
                            key: ValueKey(update.updateId),
                            isApproved: update.isApproved,
                            dateTime: update.isApproved == false ? convertDateTime(update.createdAt) : convertDateTime(update.updatedAt),
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
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Obx(()=>
        Visibility(
           visible: controller.is_button_visible.value == true
               && User.admin == homeScreenController.groupId.value ? true : false,
          child: FloatingActionButton(
            backgroundColor: MyColor.dark_cyan,
            onPressed: (){   Get.to(AddUpdateScreen());   },
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
