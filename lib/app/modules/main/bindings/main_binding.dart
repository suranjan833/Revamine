import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../mission/controllers/mission_controller.dart';
import '../../task/controllers/task_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MissionController>(() => MissionController());
    Get.lazyPut<TaskController>(() => TaskController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
