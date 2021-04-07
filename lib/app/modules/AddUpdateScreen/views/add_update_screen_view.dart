import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/ProjectScreen/controllers/project_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/dropdown_menu.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/add_update_screen_controller.dart';

class AddUpdateScreen extends StatelessWidget {


  @override
  Widget build(BuildContext add_update_screen_context) {

    AddUpdateScreenController controller = Get.put(AddUpdateScreenController());

    HomeScreenController homeScreenController = Get.find();

    return MediaQuery(
      data: myTextScaleFactor(add_update_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: 'Add Update'),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
          // automaticallyImplyLeading: false,
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: height(20.0), left: width(10.0), right: width(10.0), bottom: height(60.0)),
            child:Column(
                children: [

                  // Project title
                  Container(
                    child: Text(
                      homeScreenController.projectName,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: width(18.0), fontWeight: FontWeight.w700),
                    )
                  ),


                  Obx(()=>
                    Form(
                      key: controller.formkey.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

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
                            textEditingController: controller.descriptionController,
                            validator: (String val)=> val.isNotEmpty ? null: "Description field cannot be left blank",
                            onSaved: (String val)=> controller.descriptionController.text == val,
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
                            textEditingController: controller.link1Controller,
                            textInputAction: TextInputAction.next,
                            validator: (String val){
                              if(val.isNotEmpty && GetUtils.isURL(val)){
                                return null;
                              }
                              else if(val.isEmpty){
                                if(controller.link2Controller.text.isNotEmpty && controller.link3Controller.text.isNotEmpty){
                                return "link 1 field cannot be empty";
                                }
                                else if(controller.link3Controller.text.isNotEmpty){
                                  return "link 1 field cannot be empty";
                                }
                                else if(controller.link2Controller.text.isNotEmpty){
                                  return "link 1 field cannot be empty";
                                }
                              }
                              else{
                                return "please enter a valid url";
                              }
                            },
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
                            key: controller.field3,
                            textEditingController: controller.link2Controller,
                            textInputAction: TextInputAction.next,
                            validator: (String val){
                              if(val.isNotEmpty && GetUtils.isURL(val)){
                                return null;
                              }
                              else if(val.isEmpty){
                                if(controller.link1Controller.text.isNotEmpty && controller.link3Controller.text.isNotEmpty){
                                return "link 2 field cannot be empty";
                                }
                                else if(controller.link3Controller.text.isNotEmpty){
                                  return "link 2 field cannot be empty";
                                }
                              }
                              else{
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

                          // link 3 field
                          MyFormField(
                            key: controller.field4,
                            textEditingController: controller.link3Controller,
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
                ],
              ),
            
          ),
        ),

      ),
    );
  }
}
