import 'package:get/get.dart';

import '../controllers/change_password_screen_controller.dart';

class ChangePassowrdScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordScreenController>(
      () => ChangePasswordScreenController(),
    );
  }
}
