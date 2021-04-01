import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/clients_list_model.dart';
import '../../../services/api/dio_api.dart';
import '../../LoginScreen/controllers/login_screen_controller.dart';

class ClientsScreenController extends GetxController {
  //TODO: Implement ClientsScreenController

  final ratio1 = 2;
  final field1 = ValueKey('field1');
  int admin = 1;
  int client = 2;
  TrkoRepository trkoRepository = TrkoRepository();
  List<Client> allClients = [];
  var result;

  Future<List<Client>> getClients()async{

    allClients = await trkoRepository.allClients(token: Get.find<LoginScreenController>().token);

    return allClients;
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
