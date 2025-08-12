import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/controller/theme_controller.dart';
import 'package:flutter_getx_project/firebase_options.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      final ThemeController themeController = Get.find();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.lightTheme,
        themeMode: themeController.themeMode,
        initialRoute: Routes.splash,
        getPages: Routes.routes,
      ),
    );
  }
}
