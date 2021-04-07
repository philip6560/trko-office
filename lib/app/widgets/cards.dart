import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/EditPaymentScreen/views/edit_payment_screen_view.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import '../utils/helper.dart';
import '../modules/EditUpdateScreen/views/edit_update_screen_view.dart';
import '../modules/PaymentsScreen/controllers/payments_screen_controller.dart';
import '../utils/responsive.dart';


// used in client project, client's and home screen
class CardTemplate1 extends StatelessWidget {

  final String title; 
  final String projectStatus;
  final Function onTap;
  final double bottomMargin;

  final double radius = 10.0;
  final String projectCompleted = "1";
  final String projectNotCompleted = "0";

 CardTemplate1({Key key, this.title, this.projectStatus, this.onTap, this.bottomMargin}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: this.onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: bottomMargin == null? 0.0 : height(this.bottomMargin),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height(radius)),
        ),
        elevation: 1.0,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height(radius)),
            boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                offset: Offset(0.0, 1.0),
                color: MyColor.shadow_color1,
              ),
            ],
          ),
          child: Row(
            children: [

              // project title
              Expanded(
                flex: 14,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: width(15.0)),
                  height: height(81.0),
                  child: Text(
                    this.title, style: GoogleFonts.poppins(fontSize: height(18.0), fontWeight: FontWeight.normal, ),
                  ),
                ),
              ),

              // icon indicating projects status based on its color
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: this.projectStatus == projectCompleted ? MyColor.dark_cyan : this.projectStatus == projectNotCompleted ? MyColor.strong_orange : null,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius),)
                  ),
                  height: height(81.0),
                  child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 40.0,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// used in project details screen
class CardTemplate2 extends StatelessWidget {
  
  final String icon;
  final String name;
  final Function onTap;

  const CardTemplate2({Key key, this.name, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Card(
        margin: EdgeInsets.all(0.0),
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height(10.0)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height(10.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
                color: MyColor.shadow_color2,
              ),
            ],
          ),
          height: height(151.0),
          width: width(166.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                width: width(61.0), height: height(61.0),
                alignment: Alignment.center,
                child: SvgPicture.asset(this.icon),
              ),

              Container(
                alignment: Alignment.topCenter,
                child: Text(this.name, style: GoogleFonts.poppins(fontSize: height(18.0),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// used in payments screen
class SlidableCardTemplate extends StatelessWidget {

  final String dateTime, note, paymentId;
  final int amount;
  final SlidableController slidableController;

  SlidableCardTemplate({Key key, this.note, this.dateTime, this.amount, this.paymentId, this.slidableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PaymentsScreenController controller = Get.find();

    HomeScreenController homeScreenController = Get.find();

    print('Main : ${Get.find<PaymentsScreenController>().slidableController.activeState}');

    return Slidable(
          controller: this.slidableController,
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: CardTemplate3(note: this.note, amount: this.amount, dateTime: this.dateTime,
              slidableController: this.slidableController),
          secondaryActions: [

            Container(
            height: height(113.0),
              child: IconSlideAction(
                iconWidget: SvgPicture.asset("assets/svg/edit-white.svg"),
                color: MyColor.slightly_desaturated_yellow,
                onTap: (){
                  controller.paymentId = this.paymentId;
                  controller.amountController.text = this.amount.toString();
                  controller.noteController.text = this.note;
                  controller.dateTimeController.text = this.dateTime;

                  Get.to(EditPaymentScreen());

                },
              ),
            ),

            Container(
            height: height(113.0),
              child: IconSlideAction(
                icon: Icons.delete,
                color: MyColor.strong_red,
                onTap: ()async{
                  //delete payment
                  await controller.deletePayment(this.paymentId);
                },
              ),
            ),

          ],
        // ),
    );
  }
}

// used in payments screen
class CardTemplate3 extends StatelessWidget {

  final String dateTime, note;
  final int amount;
  final SlidableController slidableController;

  const CardTemplate3({Key key, this.dateTime, this.amount, this.note, this.slidableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('slidable state: ${this.slidableController.activeState}');
    return Card(
      elevation: 3.0,
      shadowColor: MyColor.shadow_color2,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: this.slidableController.activeState != null?
          BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)) : BorderRadius.circular(10.0),
        ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
              color: MyColor.shadow_color2,
            ),
          ],
        ),
        width: width(373.0),
        height: height(113.0),
        padding: EdgeInsets.only(left: width(14.0), top: height(16.0), bottom: height(20.0)),
        child: Column(
              children: [

                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      this.dateTime,
                      style: GoogleFonts.poppins(fontSize: height(14.0),color: MyColor.strong_orange),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: width(1.0)),
                    child: Text(
                      "${this.amount}",
                      style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_cyan,),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: width(1.0)),
                    child: Text(
                      this.note,
                      style: GoogleFonts.poppins(fontSize: height(14.0), color: MyColor.dark_gray),
                      ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}


// used in updates screen
class CardTemplate4 extends StatelessWidget {

  final String description, milestone, link1, link2, link3, dateTime;
  final String updateId;
  final bool isApproved;

  final bool approved = true;
  final bool notApproved = false;

  const CardTemplate4({Key key, this.isApproved, this.description,
    this.dateTime, this.milestone, this.link1, this.link2, this.link3,
    this.updateId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: this.isApproved == approved ? Colors.white : MyColor.pale_cyan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height(10.0)),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
              color: MyColor.shadow_color2,
            ),
          ],
        ),
        width: width(373.0),
        padding: EdgeInsets.only(left: width(14.0), top: height(15.0), bottom: height(17.0), right: width(14.0)), //,
        child: Column(
          children: [

            // topmost section
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    this.dateTime,
                    style: GoogleFonts.poppins(fontSize: height(14.0),color: MyColor.strong_orange),
                  ),

                  Text(
                    this.milestone,
                    style: GoogleFonts.poppins(fontSize: height(14.0), color: MyColor.dark_blue,),
                  ),

                ]
              ),
            ),

            SizedBox(height: height(15.0),),

            // center section
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                this.description,
                style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_gray,),
              ),
            ),

            SizedBox(height: height(30.0),),

            // bottom section
            Visibility(
              visible: this.link1 != ""? true : false,
              child: GestureDetector(
                onTap: ()=> Launch.updateLink(this.link1),
                child: Container(
                  margin: EdgeInsets.only(bottom: link2 == "" && link3 == ""? height(0.0) : height(2.0)),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    this.link1,
                    style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_cyan),
                  ),
                ),
              ),
            ),

            Visibility(
                visible: this.link2 != ""? true : false,
                child: GestureDetector(
                  onTap: ()=> Launch.updateLink(this.link2),
                  child: Container(
                    margin: EdgeInsets.only(bottom: link3 == ""? height(0.0) : height(2.0)),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      this.link2,
                      style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_cyan),
                    ),
                  ),
                ),
              ),

            Visibility(
                visible: this.link3 != ""? true : false,
                child: GestureDetector(
                  onTap: ()=> Launch.updateLink(this.link3),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      this.link3,
                      style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_cyan),
                    ),
                  ),
                ),
              ),

            // bottom-most section
            Visibility(
              visible: this.isApproved == notApproved? true : false,
              child: Container(
                alignment: Alignment.bottomRight,
                child: CardTemplate4Buttons(updateId: this.updateId, milestone: this.milestone, link3: this.link3,
                  link2: this.link2, link1: this.link1, description: this.description, dateTime: this.dateTime,),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

// used in updates screen
class CardTemplate4Buttons extends StatelessWidget {

  final String description, milestone, link1, link2, link3, dateTime;
  final String updateId;

  const CardTemplate4Buttons({Key key, this.updateId, this.milestone,
  this.description, this.link1, this.link2, this.link3, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UpdatesScreenController controller = Get.find();

    print("Description: $description, milestone: $milestone, createdAt: $dateTime, updateId: $updateId, Links: $link1, $link2, $link3 ");

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        // approve button
        GestureDetector(
          onTap: ()async{
            
            // approve function
            await controller.approveUpdate(this.updateId);

            },
          child: Container(
              child: Icon(CupertinoIcons.checkmark_alt_circle, color: MyColor.dark_cyan, size: height(24.0),)
          ),
        ),

        SizedBox(width: height(22.75),),

        // edit button
        GestureDetector(
          onTap: (){  
            controller.milestone = this.milestone;
            controller.descriptionController.text  = this.description;
            controller.link1Controller.text = this.link1;
            controller.link2Controller.text = this.link2;
            controller.link3Controller.text = this.link3;
            controller.updateId = this.updateId;
            // supply dets for editing
            Get.to(EditUpdateScreen());
            },
          child: Container(
              width: width(21.0),
              height: height(20.89),
              child: SvgPicture.asset("assets/svg/edit-black.svg")
          ),
        ),

        SizedBox(width: height(20.75),),

        // delete button
        GestureDetector(
          onTap: ()async{

            // delete call
            await controller.deleteUpdate(this.updateId);

          },
            child: Icon(Icons.delete, size: height(24.0),),
        ),
      ],
    );
  }
}


// used in updates screen
class CardConnector extends StatelessWidget {

  const CardConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(28.0),
      height: height(28.0),
      child: SvgPicture.asset("assets/svg/connector.svg"),
    );
  }
}




