import 'package:flutter_getx_project/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';


class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}