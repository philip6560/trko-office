
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyColor{
  static const dark_blue = Color.fromRGBO(2, 56, 89, 1.0);
  static const greenish = Color.fromRGBO(128, 185, 192, 1.0);
  static const whitishred = Color.fromRGBO(165, 165, 165, 1.0);
  static const white = Color.fromRGBO(225, 225, 225, 1.0);
  static const dark_cyan = Color.fromRGBO(2, 115, 115, 1.0);
  static const strong_orange = Color.fromRGBO(209, 105, 0, 1.0);
  static const light_grayish_red = Color.fromRGBO(245, 244, 244, 1.0);
  static const dark_gray = Color.fromRGBO(112, 112, 112, 1.0);
  static const strong_red = Color.fromRGBO(209, 0, 0, 1.0);
  static const slightly_desaturated_yellow = Color.fromRGBO(192, 180, 128, 1.0);
  static const pale_cyan = Color.fromRGBO(240, 253, 255, 1.0);
  static const formfield_border = Color.fromRGBO(190, 190, 190, 1.0);
  static const formfield_label = Color.fromRGBO(48, 48, 48, 1.0);
  static const shadow_color1 = Color.fromRGBO(0, 0, 0, 0.007);
  static const shadow_color2 = Color.fromRGBO(0, 0, 0, 0.016);
}


// general text scale factor
 MediaQueryData myTextScaleFactor(BuildContext context) => Get.context.mediaQuery.copyWith(textScaleFactor:
 MediaQuery.of(context).textScaleFactor.clamp(0.85, 1.0));

class Launch{

  static const url = "https://api.whatsapp.com/send?phone=2347015152515";
  static const phoneNumber = "tel:07015152515";
  static const errorResponse = "Oops! could not contact help center.";


  static call()async{

    if (await canLaunch(phoneNumber)){

      await launch(phoneNumber);
    }
    else{
      return errorResponse;
    }

  }

  static whatsApp()async{

    if(await canLaunch(url)){

      await launch(url);
    }
    else{
      return errorResponse;
    }

  }

  static updateLink(String url)async{

    if(await canLaunch(url)){

      await launch(url);
    }
    else{
      return errorResponse;
    }

  }

}



// convert date and time string to the appropriate format
convertDateTime(String dateTime){

  String pattern1 = "T";    String pattern2 = ".";
  List temp = [];
  String converted = "";
  String tempString;

  // split into a date to temp[0] and time with Z to temp[1]
  dateTime.split(pattern1).forEach((element) {
    temp.add(element);
  });

  // date already gotten
  converted = temp[0] + " " ;

  // uncleaned time string with "." and "Z"
  tempString  = temp[1];

  // re-initialize temp 
  temp = [];

  tempString.split(pattern2).forEach((element){
    temp.add(element);
  });

  // cleaned time
  tempString = temp[0];

  // match using the first two digit of the time string
  var match = int.parse(tempString.toString().substring(0,2));

  // append "Am" or "Pm" depending on the first two digit of the cleaned time
  if( match >= 12 ){

    return converted = converted + tempString + " pm";

  }
  else{

    return converted = converted + " " + tempString + " am";

  }
}


// helps remove the bracket at the beginning and end of the data gotten from the milestone list
cleanMilestone(var milestoneValue){

  milestoneValue = milestoneValue.toString().substring(1, (milestoneValue.toString().length -1));

  return milestoneValue;

}


class Storage{

  static FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future write({String key, String value})async{

    var writtenData = await secureStorage.write(key: key, value: value,);

    return writtenData;
  }


  static Future read({String key})async{

    var readData = await secureStorage.read(key: key);

    return readData;
  }


  static Future readAll()async{

    Map<String, String> readAllData = await secureStorage.readAll();

    return readAllData;
  }


  static Future delete({String key})async{

    var deleteData = await secureStorage.delete(key: key);

    return deleteData;
  }


  static Future deleteAll()async{

    var deleteAllData = await secureStorage.deleteAll();

    return deleteAllData;
  }
}


