import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../localdb/appSharedPrefre.dart';


class HomeController extends GetxController with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final RxBool _isHidden = true.obs;
  final RxBool valuesecond = true.obs;
  final RxBool activeConnection = false.obs;


  var errorString = "".obs;
  var alexaurl = "";

  //  'https://alexa.amazon.com/spa/skill-account-linking-consent?fragment=skill-account-linking-consent &client_id=amzn1.application-oa2-client.904ffc1e31e0402699bc2f7e27964d71 &scope=alexa::skills:account_linking &skill_stage=live &response_type=code &redirect_uri=carlito%3A%2F%2Fauth%2Fcallback&state=';

  var profileData = {}.obs;
  var userPhoto = ''.obs;
  String _email = "";
  final TextEditingController first = TextEditingController();
  final TextEditingController txtCntDeviceNo = TextEditingController();

  late loc.Location locationR;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> refreshIndicatorKey = GlobalKey<
      LiquidPullToRefreshState>();
  final formKey = GlobalKey<FormState>();
  var deviceList = [].obs;

  var isLoading = false.obs;

  String randomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }


  @override
  Future<void> onInit() async {
    super.onInit();

    deviceList.addAll([
      {
        "device": "Smart Plug",
        "icon": "smartplug"
      },
      {
        "device": "Neon LED",
        "icon": "neon"
      },
      {
        "device": "Neon LED",
        "icon": "neon"
      },
    ]);

    WidgetsBinding.instance.addObserver(this);
    locationR = loc.Location();

    //  alexaurl =alexaurl+randomString(16);

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((
            List<ConnectivityResult> resultList) {
          final result = resultList.isNotEmpty
              ? resultList.first
              : ConnectivityResult.none;
          _updateConnectionState(result);
        });
    // await getDeviceList();

    //await requestLocationPermission();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //  MqttHandler.instance.connect();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("+++didChangeAppLifecycleState ${state.name}");
  }


  Future<void> requestLocationPermission() async {
    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;
    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      // getCurrentLocation();
    }
  }

  Future checkGps() async {
    var isEnable = await locationR.serviceEnabled();
    if (!isEnable) {
      locationR.requestService();
    }
  }

  Future<bool> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      activeConnection.value =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return activeConnection.value;
    } on SocketException catch (_) {
      activeConnection.value = false;
      return false;
    }
  }


  Future<void> initConnectivity() async {
    try {
      final resultList = await _connectivity.checkConnectivity();
      final resultconnectivity = resultList.isNotEmpty
          ? resultList.first
          : ConnectivityResult.none;
      await _updateConnectionState(resultconnectivity);
    } on PlatformException catch (e) {
      print("Connectivity check failed: ${e.toString()}");
    }
  }

  Future<void> _updateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      await checkUserConnection();
    } else {
      await checkUserConnection();
      Get.snackbar('nointernet'.tr, 'plscheckconn'.tr,
          backgroundColor: Colors.grey);
    }
  }

  Future<void> logoutUser() async {
    Get.dialog(
      AlertDialog(

        title: Text(
          'Confirm Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Icon(Icons.logout, size: 48, color: Colors.red),*/

            Text('Are you sure you want to logout?'),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        actions: [
          TextButton(
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text(
              'LOGOUT',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              await SharedPrefre.clearSharedPre();

              Get.offAllNamed('/login_screen');
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );


    //  Get.offAll(() => MyHomePage());
  }

  String assetsimg(String? deviceno) {
    if (deviceno == '0') return 'assets/icons/masterbed.svg';
    if (deviceno == '1') return 'assets/icons/bed.svg';
    if (deviceno == '2') return 'assets/icons/guestbed.svg';
    if (deviceno == '3') return 'assets/icons/kidbed.svg';
    if (deviceno == '4') return 'assets/icons/masterbed2.svg';
    if (deviceno == '5') return 'assets/icons/drawingroom.svg';
    return 'assets/icons/about.svg';
  }

  void navigateToAddDevice() {}


  // Toggle methods

  Future<void> handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      // getDeviceList();

    });
  }
}




