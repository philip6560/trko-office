import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/dropdown_menu.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/edit_update_screen_controller.dart';

class EditUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext edit_update_screen_context) {

    EditUpdateScreenController controller = Get.put(EditUpdateScreenController());

    UpdatesScreenController updatesScreenController = Get.find();

    controller.getMilestoneId(updatesScreenController.milestone);

    print("this is the link1controller ${controller.currentItem.value}");

    return MediaQuery(
      data: myTextScaleFactor(edit_update_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: 'Edit Update'),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: height(20.0), left: width(10.0), right: width(10.0), bottom: height(40.0)),

              child: Obx(()=>
                Form(
                  key: controller.formkey.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Project title
                      Container(
                          child: Text(
                            Get.find<HomeScreenController>().projectName,
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: width(18.0), fontWeight: FontWeight.w700),
                          )
                      ),

                      SizedBox(height: height(25.5),),

                      // milestone label
                      FieldLabel(
                        labelname: "Milestone",
                      ),

                      SizedBox(height: height(9.0),),

                      // list of milestones
                      MileStonesList(currentItem: controller.currentItem.value, onChanged: controller.selectedItem,),

                      SizedBox(height: height(23.5),),

                      // description field label
                      FieldLabel(
                        labelname: "What's Completed?",
                      ),

                      SizedBox(height: height(11.0),),

                      // Description field
                      DescriptionField(
                        key: controller.field1,
                        textEditingController: updatesScreenController.descriptionController,
                        validator: (String val)=> val.isNotEmpty ? null: "Description field cannot be left blank",
                        onSaved: (String val)=> updatesScreenController.descriptionController.text = val,
                      ),

                      SizedBox(height: height(20.5),),

                      // link 1 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 1',
                      ),

                      SizedBox(height: height(9.0),),

                      // link 1 field
                      MyFormField(
                        key: controller.field2,
                        textEditingController: updatesScreenController.link1Controller,
                        textInputAction: TextInputAction.next,
                        validator: (String val){
                          if(val.isNotEmpty && GetUtils.isURL(val)){
                            return null;
                          }
                          else if(val.isEmpty){
                            if(updatesScreenController.link2Controller.text.isNotEmpty && updatesScreenController.link3Controller.text.isNotEmpty){
                            return "link 1 field cannot be empty";
                            }
                            else if(updatesScreenController.link3Controller.text.isNotEmpty){
                              return "link 1 field cannot be empty";
                            }
                            else if(updatesScreenController.link2Controller.text.isNotEmpty){
                              return "link 1 field cannot be empty";
                            }
                          }
                          else{
                            return "please enter a valid url";
                          }
                        },
                        onSaved: (String val)=> updatesScreenController.link1Controller.text = val,
                      ),

                      SizedBox(height: height(23.0),),

                      // link 2 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 2',
                      ),

                      SizedBox(height: height(9.0),),

                      // link 2 field
                      MyFormField(
                        key: controller.field3,
                        textEditingController: updatesScreenController.link2Controller,
                        textInputAction: TextInputAction.next,
                        validator: (String val){
                          if(val.isNotEmpty && GetUtils.isURL(val)){
                            return null;
                          }
                          else if(val.isEmpty){
                            if(updatesScreenController.link1Controller.text.isNotEmpty && updatesScreenController.link3Controller.text.isNotEmpty){
                            return "link 2 field cannot be empty";
                            }
                            else if(updatesScreenController.link3Controller.text.isNotEmpty){
                              return "link 2 field cannot be empty";
                            }
                          }
                          else{
                            return "please enter a valid url";
                          }
                        },                        
                        onSaved: (String val)=> updatesScreenController.link2Controller.text = val,
                      ),

                      SizedBox(height: height(23.0),),

                      // link 3 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 3',
                      ),

                      SizedBox(height: height(9.0),),

                      // link 3 field label
                      MyFormField(
                        key: controller.field4,
                        textEditingController: updatesScreenController.link3Controller,
                        textInputAction: TextInputAction.done,
                        validator: (String val){
                          if(val.isNotEmpty & GetUtils.isURL(val)){
                            return null;
                          }
                          else if(val.isEmpty){
                            return null;
                          }
                          else{
                            return "please enter a valid url";
                          }
                        },
                        onSaved: (String val)=> updatesScreenController.link3Controller.text = val,
                      ),

                      SizedBox(height: height(32.5),),

                      // save button
                      Center(
                          child: PrimaryButton(
                            label: "Save", margin: EdgeInsets.symmetric(horizontal: width(47.0), ), onPressed: (){ controller.validate(); },
                          )
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
