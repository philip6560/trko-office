
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import '../utils/responsive.dart';
import '../utils/helper.dart';

class MileStonesList extends StatelessWidget {

  final Function onChanged;
  final int currentItem;

  MileStonesList({Key key, this.onChanged, this.currentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UpdatesScreenController controller = Get.find();

    return Container(
        padding: EdgeInsets.only(left: width(25.0), right: width(15.0), top: height(3.0)),
        width: width(373.0),
        height: height(56.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height(30.0)),
          border: Border.all(color: MyColor.formfield_border),
        ),
        child: DropdownButton(
          hint: Text("Select Milestone", style: GoogleFonts.poppins(fontSize: height(18.0))),
          isExpanded: true,
          underline: Container(),
          onChanged: this.onChanged,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: MyColor.dark_blue, size: height(35.0),),
          value: this.currentItem,
          items: List.generate(controller.milestoneList.length, (index) => DropdownMenuItem(
            value: index,
            // clean string before displaying
            child: Text("${controller.cleanMilestone(controller.milestoneList[index].values)}",
              style: GoogleFonts.poppins(fontSize: height(18.0)),
            ),
          )),
        ),
    );
  }
}