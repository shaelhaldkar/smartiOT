import 'package:get/get.dart';
import 'package:smart_device/screens/homescreen/adddevices/SmartConfigController.dart';



class SmartConfigBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<SmartConfigController>(SmartConfigController());
  }
}