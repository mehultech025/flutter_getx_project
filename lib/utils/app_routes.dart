import 'package:flutter_getx_project/screens/bottom_navigation/binding/bottom_navigation_binding.dart';
import 'package:flutter_getx_project/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:flutter_getx_project/screens/chat/binding/chat_binding.dart';
import 'package:flutter_getx_project/screens/chat/chat_detail_screen.dart';
import 'package:flutter_getx_project/screens/home/home_screen.dart';
import 'package:flutter_getx_project/screens/login/binding/login_bindings.dart';
import 'package:flutter_getx_project/screens/login/login_screen.dart';
import 'package:flutter_getx_project/screens/register/binding/register_bindings.dart';
import 'package:flutter_getx_project/screens/register/register_screen.dart';
import 'package:flutter_getx_project/screens/setting/theme/custom_theme.dart';
import 'package:flutter_getx_project/screens/setting/theme/theme_setting.dart';
import 'package:flutter_getx_project/screens/splash_screen.dart';
import 'package:get/get.dart';


class Routes {
  static String splash = "/splashScreen";
  static String bottomNavigation = "/bottomNavigationScreen";
  static String login = "/loginScreen";
  static String register = "/registerScreen";
  static String home = "/homeScreen";
  static String themeSettings = "/themeSettingsScreen";
  static String themeSwitcher = "/themeSwitcherScreen";
  static String chatScreen = "/chatScreen";


  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: bottomNavigation,
      page: () =>  BottomNavigationScreen(),
      binding: BottomNavigationBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => const LogInScreen(),
      binding: LoginBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBindings(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: themeSettings,
      page: () => const ThemeSettingsScreen(),
      binding: RegisterBindings(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: themeSwitcher,
      page: () =>  ThemeSwitcherScreen(),
      binding: RegisterBindings(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: chatScreen,
      page: () =>  ChatDetailScreen(),
      binding: ChatBinding(),
      transition: Transition.fadeIn,
    ),

  ];
}
