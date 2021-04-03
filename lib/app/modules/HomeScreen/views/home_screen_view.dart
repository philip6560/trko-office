import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/ClientsScreen/controllers/clients_screen_controller.dart';
import 'package:trko_official/app/modules/ClientsScreen/views/clients_screen_view.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/ProjectScreen/views/project_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import '../../../models/client_project_model.dart';
import '../../../widgets/cards.dart';
import '../../../widgets/loading_widget.dart';
import '../../ProjectScreen/views/project_screen_view.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext home_screen_context) {

    HomeScreenController controller = Get.put(HomeScreenController(),);

    LoginScreenController loginScreenController = Get.find();

    controller.clientId = loginScreenController.group_id == controller.admin ? 
    Get.find<ClientsScreenController>().clientId : Get.arguments["client_id"]; // consider using login controller
    

    print("I came to HomeScreen");
    
    return  MediaQuery(
      data: myTextScaleFactor(home_screen_context),
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: MyColor.dark_blue,
          leading: Visibility(
            visible: controller.client == loginScreenController.group_id ? false : true,
            child: NavbackButton(onTap: (){   Get.back(closeOverlays: true);   },)
            ),
          leadingWidth: controller.client == loginScreenController.group_id ? 0.0 : NavbackButton.leading_width,
          title: ScreenName(screen_name: controller.client == loginScreenController.group_id ? "Home" : "Client's Projects"),
          titleSpacing: controller.client == loginScreenController.group_id ? width(15.0) : NavbackButton.titlespacing,
          centerTitle: false,
          actions: [
            // first icon button
            Visibility(
              visible: false,
              child: AppbarButton(
                icon: 'assets/svg/customer svg.svg', onTap: (){  Get.to(ClientsScreen());  }, rightMargin: 18.0,
                )
              ),

            // second icon button
            Visibility(
              visible: loginScreenController.group_id == controller.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/phone-call svg.svg', onTap: (){ Launch.call(); }, rightMargin: 26.0,
                )
              ),

            // third icon button
            Visibility(
              visible: loginScreenController.group_id == controller.client ? true : false,
              child: AppbarButton(
                icon: 'assets/svg/whatsapp svg.svg', onTap: () {  Launch.whatsApp();  }, rightMargin: 18.0,
                )
              ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: height(31.0), left: width(10.0), right: width(10.0)),
              child: Obx(()=>
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    
                    // check if client project list is empty
                    controller.clientProject.isEmpty ?

                    Loading(isFullScreen: true,) : // else
                    
                    // if api call returns error
                    controller.clientProject[0].id == null && controller.clientProject[0].message != null ?

                    refreshProjectScreen(
                      message: controller.clientProject[0].message,
                      label: "refresh",
                      onTap: (){ 
                        controller.onReady();  
                      },
                      statusCode: controller.clientProject[0].statusCode,
                      isFullScreen: true,
                    ) 
                    
                    : // else client's project were gotten
                  
                    // display client's project
                    ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.clientProject.length,
                      itemBuilder: (context, index) {
                        Project project = controller.clientProject[index];
                        return CardTemplate1(
                          key: ValueKey(project.id),
                          title: project.title,
                          bottomMargin: 21.0,
                          projectStatus: project.status,
                          onTap: () {
                            controller.description = project.description;
                            controller.projectId = project.id;
                            controller.projectName = project.title;
                            controller.startDate = project.startDate;
                             Get.to(ProjectScreen(),);
                          },
                        );
                      },
                    ),        
                  ],
                ),
              ),
            ),
        ),



        floatingActionButton: Obx(()=>
          Visibility( 
            visible: controller.is_button_visible.value == true && loginScreenController.group_id == controller.client ? true : false,
            child: FloatingActionButton(
              backgroundColor: MyColor.dark_cyan,
              onPressed: (){   
                changePassword(context: Get.context);
                 },
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
  