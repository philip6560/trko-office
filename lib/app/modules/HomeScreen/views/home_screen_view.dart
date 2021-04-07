import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/ClientsScreen/views/clients_screen_view.dart';
import 'package:trko_official/app/modules/ProjectScreen/views/project_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import '../../../models/client_project_model.dart';
import '../../../models/user_model.dart';
import '../../../widgets/cards.dart';
import '../../../widgets/loading_widget.dart';
import '../../LoginScreen/views/login_screen_view.dart';
import '../../ProjectScreen/views/project_screen_view.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext home_screen_context) {

    HomeScreenController controller = Get.put(HomeScreenController(),);

    print("I came to HomeScreen");

    return  MediaQuery(
      data: myTextScaleFactor(home_screen_context),
      child: Obx(()=>
        Scaffold(

          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColor.dark_blue,
            leading: Visibility(
              visible: User.client == controller.groupId.value ? false : true,
              child: NavbackButton(),
              ),
            leadingWidth: User.client == controller.groupId.value ? 0.0 : NavbackButton.leading_width,
            title: ScreenName(screen_name: User.client == controller.groupId.value ? "Home" : "Client's Projects"),
            titleSpacing: User.client == controller.groupId.value ? width(15.0) : NavbackButton.titlespacing,
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
                visible: controller.groupId.value == User.client ? true : false,
                child: AppbarButton(
                  icon: 'assets/svg/phone-call svg.svg', onTap: (){ Launch.call(); }, rightMargin: 26.0,
                  )
                ),

              // third icon button
              Visibility(
                visible: controller.groupId.value == User.client ? true : false,
                child: AppbarButton(
                  icon: 'assets/svg/whatsapp svg.svg', onTap: () {  Launch.whatsApp();  }, rightMargin: 18.0,
                  )
                ),

              // fourth icon button
              Visibility(
                visible: controller.groupId.value == User.client ? true : false,
                child: GestureDetector(
                  onTap: ()async{
                    await Storage.write(key: "navBack", value: "false");
                    await Storage.write(key: "persistLogin", value: "false");
                    Get.offAll(LoginScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: width(18.0)),
                      child: Icon(Icons.logout),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: height(31.0), left: width(10.0), right: width(10.0)),
                child:
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
                              controller.budget = project.budget;
                               Get.to(ProjectScreen(),);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                // ),
              ),
          ),



          floatingActionButton: Obx(()=>
            Visibility(
              visible: controller.is_button_visible.value == true && controller.groupId.value == User.client ? true : false,
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
      ),
    );
  }
}
  