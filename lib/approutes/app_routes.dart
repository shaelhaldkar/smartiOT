import 'package:get/get.dart';

import '../screens/forget_password/forget_password_binding.dart';
import '../screens/forget_password/forget_password_view.dart';
import '../screens/homescreen/adddevices/smart_config_view.dart';
import '../screens/homescreen/adddevices/smartconfig_binding.dart';
import '../screens/homescreen/home_binding.dart';
import '../screens/homescreen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/login_screen/login_screen_binding.dart';

class AppRoutes {
  static final List<GetPage> routes = [

    GetPage(
      name: '/login_screen',
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/home_screen',
      page: () =>  HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: '/forget_password',
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: '/smartconfigscreen',
      page: () =>  SmartConfigScreen(),
      binding: SmartConfigBinding(),
    ),


  ];
}
