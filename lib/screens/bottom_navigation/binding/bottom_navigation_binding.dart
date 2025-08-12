import 'package:flutter_getx_project/screens/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:get/get.dart';

class BottomNavigationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavController>(BottomNavController());
  }
}
