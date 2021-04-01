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
import '../../../widgets/loading_widget.dart';
import '../../../widgets/loading_widget.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // searchbox field label
                FieldLabel(
                  labelname: 'Search',
                ),

                SizedBox(height: height(9.0),),

                // searchbox field
                MyFormField(
                  fieldKey: controller.field1,
                ),

                SizedBox(height: height(22.0),),

                // Futurebuilder in conjuction with list view builder are to be utilized for the results.
                // search results
                FutureBuilder<List<Client>>(
                  future: controller.getClients(),
                  builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {

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
                          Client client = snapshot.data[index];
                          return CardTemplate1(
                            key: ValueKey(client.id),
                            title: client.companyName,
                            bottomMargin: 19.0,
                            onTap: () {
                              Get.to(HomeScreen(),
                                  arguments: {"client_id": client.id});
                            },
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
      ),
    );
  }
}
