import 'package:get/get.dart';

class ProjectScreenController extends GetxController {
  //TODO: Implement ProjectScreenController
  int client = 2;
  int admin = 1;

  final count = 0.obs;

  convertToDate({String dateTime}){
    String findT = "T";
    List temp = [];
    dateTime.split(findT).forEach((element)=> temp.add(element));

    print("$temp");

    return temp[0];

  }

  convertDescription({String description}){
    String pattern1 = "<p>";
    String pattern2 = r"</p>";
    String pattern3 = "<br>";
    List converted = [];
    String cleaned = "";

    List temp = [];


    description.split(pattern2).forEach((element1) {
      element1.split(pattern3).forEach((element2) {
       element2.split(pattern1).forEach((element)=> temp.add(element));
      });
    });

    temp.forEach((element){
      if(element != ""){
        converted.add(element);
      }
    });

    for(int x = 0; x < converted.length; x++){
      cleaned = cleaned + converted[x];
    }

    return cleaned;


  }




  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
