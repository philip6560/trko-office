import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

    controller.milestone = Get.arguments["milestone"];

    controller.getMilestoneId(controller.milestone);

    controller.descriptionController.text = Get.arguments["description"];
    controller.link1Controller.text = Get.arguments["link1"];
    controller.link2Controller.text = Get.arguments["link2"];
    controller.link3Controller.text = Get.arguments["link3"];
    controller.updateId = Get.arguments["updateId"];


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
                            Get.find<UpdatesScreenController>().projectName,
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
                        fieldKey: controller.field1,
                        textEditingController: controller.descriptionController,
                        validator: (String val)=> val.isNotEmpty ? null: "Description field cannot be left blank",
                        onSaved: (String val)=> controller.descriptionController.text = val,
                      ),

                      SizedBox(height: height(20.5),),

                      // link 1 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 1',
                      ),

                      SizedBox(height: height(9.0),),

                      // link 1 field
                      MyFormField(
                        fieldKey: controller.field2,
                        textEditingController: controller.link1Controller,
                        textInputAction: TextInputAction.next,
                        validator: (String val)=> val.isNotEmpty? GetUtils.isURL(val)?
                        null:"please enter a valid url"
                            : null,
                        onSaved: (String val)=> controller.link1Controller.text = val,
                      ),

                      SizedBox(height: height(23.0),),

                      // link 2 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 2',
                      ),

                      SizedBox(height: height(9.0),),

                      // link 2 field
                      MyFormField(
                        fieldKey: controller.field3,
                        textEditingController: controller.link2Controller,
                        textInputAction: TextInputAction.next,
                        validator: (String val){
                          if(val.isNotEmpty && GetUtils.isURL(val)){
                            if(controller.link1Controller.text.isEmpty && GetUtils.isURL(val)){
                              return "link 1 field cannot be empty";
                            }
                            else{
                              return null;
                            }
                          }
                          if(val.isEmpty){
                            return null;
                          }else{
                            return "please enter a valid url";
                          }
                        },
                        onSaved: (String val)=> controller.link2Controller.text = val,
                      ),

                      SizedBox(height: height(23.0),),

                      // link 3 field label
                      FieldLabel(
                        labelname: 'Any Link To Access 3',
                      ),

                      SizedBox(height: height(9.0),),

                      // note field
                      MyFormField(
                        fieldKey: controller.field4,
                        textEditingController: controller.link3Controller,
                        textInputAction: TextInputAction.done,
                        validator: (String val){
                          if(val.isNotEmpty && GetUtils.isURL(val)){
                            if(controller.link1Controller.text.isEmpty && controller.link2Controller.text.isEmpty){
                              return "link 1 and link 2 field cannot be empty";
                            }
                            else{
                              return null;
                            }
                          }
                          if(val.isEmpty){
                            return null;
                          }
                          else{
                            return "please enter a valid url";
                          }
                        },
                        onSaved: (String val)=> controller.link3Controller.text = val,
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
