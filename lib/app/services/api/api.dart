import 'package:trko_official/app/models/clients_list_model.dart';
import 'package:trko_official/app/models/user_model.dart';

abstract class Api{

  Future<CallResponse> login({String email, String password});

  Future allProjects({String token});

  Future clientProjects({String token});

  Future<Client> allClients({String token});

  Future resetPassword({String token, String oldPassword, String newPassword});

  Future projectUpdates({String token, String projectId});

  Future addUpdate({String token, String projectId, String milestone, String descripition, String link1, String link2, String link3});

  Future editUpdate({String token, String projectId, String updateId, String milestone, String descripition, String link1, String link2, String link3});

  Future deleteUpdate({String token, String updateId});

  Future confirmUpdate({String token, String updateId});

  Future projectPayments({String token, String projectId});

  Future addPayment({String token, String projectId, String amount, String note, String dateTime});

  Future editPayment({String token, String projectId, String paymentId, String amount, String note, String dateTime});

  Future deletePayment({String token, String paymentId});

}


// Future milestones();