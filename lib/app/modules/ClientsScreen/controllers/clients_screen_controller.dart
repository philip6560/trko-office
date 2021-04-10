import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/clients_list_model.dart';
import '../../../services/api/dio_api.dart';
import '../../../utils/helper.dart';
import '../../../utils/helper.dart';
import '../../LoginScreen/controllers/login_screen_controller.dart';

class ClientsScreenController extends GetxController {
  //TODO: Implement ClientsScreenController

  final ratio1 = 2;
  final field1 = ValueKey('searchField1');
  TrkoRepository trkoRepository = TrkoRepository();
  var allClients = List<Client>().obs;
  var result;
  String groupId;
  TextEditingController searchController = TextEditingController();
  List<Client> unSorted = []; //clone of allClients list

  // search algo
  clientSearch(String keyword){

    keyword = keyword.toUpperCase();

    List<Client> sorted = [];// list to collect sorted clients
    String temp;

    if(keyword.isEmpty){

      allClients.assignAll(unSorted);

      return allClients;

    }
    else{

      if(allClients.isNotEmpty){

        allClients.forEach((element) {
          temp = element.companyName.substring(0, keyword.length).toUpperCase();
          if(keyword == temp){
            sorted.add(element);
          }
        });

        if(sorted.isEmpty){

          return allClients.assign(Client(id: null, companyName: "Match not found"));
        }
        else{

          return allClients.assignAll(sorted);
        }

      }

    }
  }


  getCredentials()async{

    groupId = await Storage.read(key: "groupId");

    print("$groupId");
  }

  Future<List<Client>> getClients()async{

    String token = await Storage.read(key: "token");

    result = await trkoRepository.allClients(token: token);

    allClients.assignAll(result);

    unSorted.assignAll(result);

    return allClients;
  }

  @override
  void onInit() async{
    await getCredentials();
    super.onInit();
  }

  @override
  void onReady() {
    getClients();
    super.onReady();
  }

  @override
  void onClose() {}
}
