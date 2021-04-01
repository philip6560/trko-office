import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/ChangePasswordScreen/views/change_password_screen_view.dart';
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

    controller.clientId = Get.arguments["client_id"];
    LoginScreenController loginScreenController = Get.find();

    
    return  MediaQuery(
      data: myTextScaleFactor(home_screen_context),
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: MyColor.dark_blue,
          leading: Visibility(
            visible: controller.client == loginScreenController.group_id ? false : true,
            child: NavbackButton()
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // Futurebuilder in conjuction with list view builder are to be utilized for the results.
                // search results
                FutureBuilder<List<Project>>(
                    future: controller.getClientProjects(),
                    builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {

                      // Loading icon
                      if (snapshot.hasError) {
                        return refreshProjectScreen(message: "Oops! check your internet connection", label: "refresh", statusCode: null);
                      }

                      // Load clients when data is fetched successfully
                      if (snapshot.hasData && snapshot.data[0].id != null){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Project project = snapshot.data[index];
                            return CardTemplate1(
                              key: ValueKey(project.id),
                              title: project.title,
                              bottomMargin: 21.0,
                              projectStatus: project.status,
                              onTap: () {  Get.to(ProjectScreen(), arguments: {"description": project.description,
                                "startDate": project.startDate, "title": project.title, "projectId": project.id,
                              "clientId": controller.clientId, "budget": project.budget});  },
                            );
                          },
                        );
                      }

                      // refresh screen to re-fetch clients
                      else{
                        return Loading();
                      }
                    }
                ),
              ],
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
  