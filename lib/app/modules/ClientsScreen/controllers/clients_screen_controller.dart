import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/clients_list_model.dart';
import '../../../services/api/dio_api.dart';
import '../../LoginScreen/controllers/login_screen_controller.dart';

class ClientsScreenController extends GetxController {
  //TODO: Implement ClientsScreenController

  final ratio1 = 2;
  final field1 = ValueKey('searchField1');
  int admin = 1;
  int client = 2;
  TrkoRepository trkoRepository = TrkoRepository();
  var allClients = List<Client>().obs;
  var result;
  int clientId;

  Future<List<Client>> getClients()async{

    result = await trkoRepository.allClients(token: Get.find<LoginScreenController>().token);

    allClients.assignAll(result);

    return allClients;
  }

  @override
  void onInit() {
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
