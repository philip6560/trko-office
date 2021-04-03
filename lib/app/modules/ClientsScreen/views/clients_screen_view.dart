import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trko_official/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../../../models/clients_list_model.dart';
import '../../../widgets/cards.dart';
import '../../../widgets/loading_widget.dart';
import '../../HomeScreen/views/home_screen_view.dart';
import '../controllers/clients_screen_controller.dart';

class ClientsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClientsScreenController controller = Get.put(ClientsScreenController());

    LoginScreenController loginScreenController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
          visible: controller.admin == loginScreenController.group_id ? false : true,
          child: NavbackButton()
          ),
        leadingWidth: controller.admin == loginScreenController.group_id ? 0.0 : NavbackButton.leading_width,
        title: ScreenName(screen_name: 'Clients',),
        titleSpacing: controller.admin == loginScreenController.group_id ? width(15.0) : NavbackButton.titlespacing,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: height(16.0), left: width(10.0), right: width(10.0)),
            child: Obx(()=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // searchbox field label
                  FieldLabel(
                    labelname: 'Search',
                  ),

                  SizedBox(height: height(9.0),),

                  // searchbox field
                  MyFormField(
                    key: controller.field1,
                  ),

                  SizedBox(height: height(22.0),),  
                  
                      
                  // check if allClient's list is empty
                  controller.allClients.isEmpty ?

                  Loading(isFullScreen: false,) : // else
                  
                  // if api call returns error
                  controller.allClients[0].id == null && controller.allClients[0].message != null ?

                  refreshProjectScreen(
                    message: controller.allClients[0].message,
                    label: "refresh",
                    onTap: (){ 
                      controller.onReady();  
                    },
                    statusCode: controller.allClients[0].statusCode,
                    isFullScreen: false,
                  )

                  : // else list containing all client was gotten

                  // allClient's List were gotten display them
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.allClients.length,
                    itemBuilder: (context, index) {
                      Client client = controller.allClients[index];
                      return CardTemplate1(
                        key: ValueKey(client.id),
                        title: client.companyName,
                        bottomMargin: 19.0,
                        onTap: () {
                          controller.clientId= client.id;
                           Get.to(HomeScreen(),);
                        },
                      );
                    },
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
