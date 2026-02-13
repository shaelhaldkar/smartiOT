import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../screens/forget_password/forget_password_binding.dart';
import '../screens/forget_password/forget_password_view.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/login_screen/login_screen_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/home_screen/home_screen_binding.dart';

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
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: '/forget_password',
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),


  ];
}
