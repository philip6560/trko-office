import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../../../models/clients_list_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/helper.dart';
import '../../../widgets/cards.dart';
import '../../../widgets/loading_widget.dart';
import '../../HomeScreen/views/home_screen_view.dart';
import '../../LoginScreen/views/login_screen_view.dart';
import '../controllers/clients_screen_controller.dart';

class ClientsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClientsScreenController controller = Get.put(ClientsScreenController());

    return MediaQuery(
      data: myTextScaleFactor(context),
      child: Scaffold(
        appBar: AppBar(
          title: ScreenName(screen_name: 'Clients',),
          centerTitle: false,
          actions: [
            // logout icon button
            GestureDetector(
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
          ],
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
                      textInputAction: TextInputAction.done,
                      textEditingController: controller.searchController,
                      onChanged: (val)=> val.isEmpty? controller.clientSearch(val) : controller.clientSearch(val),
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

                    : // else check if all clients list is empty

                    // if allClients has no client
                    controller.allClients[0].id == null && controller.allClients[0].companyName != null ?

                    Container(
                      margin: EdgeInsets.only(top: height(270.0)),
                      alignment: Alignment.center,
                      child: Text(controller.allClients[0].companyName, style: GoogleFonts.poppins(fontSize: height(17.0), color: Colors.black,)),
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
                          onTap: () async{
                            await Storage.write(key: "clientId", value: "${client.id}");
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
      ),
    );
  }
}
