import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_device/utils/app_colors.dart';

import '../../utils/helpers.dart';
import '../../utils/images.dart';
import 'home_controller.dart';


class HomeScreen extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Sizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          key: controller.scaffoldKey,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.red,
          appBar: AppBar(
            backgroundColor: Colors.grey,
           /* leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 3.h),
              onPressed: () => controller.scaffoldKey.currentState!.openDrawer(),
            ),*/
            actions: [
           //   if (Platform.isAndroid)
                IconButton(
                    onPressed: () => controller.navigateToAddDevice(),
                    icon: Icon(Icons.add, color: Colors.white),),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Padding(
                padding: EdgeInsets.only(left: 2.h, right: 2.h),
                child: Divider(
                  height: 1.h,
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () => Helpers.showExitDialog(context),
            child: SingleChildScrollView(
              child: Container(
                height: 100.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: App_colors.gradient_bg_grey
                ),
                child: _buildDeviceList(),
              ),
            ),
          ),
        );
      }),
    );
  }




  Widget _buildDeviceList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.deviceList.isEmpty) {
        return _buildNoDeviceView();
      } else {
        return _buildDeviceGridView();
      }
    });
  }

  Widget _buildNoDeviceView() {
    return Container(
      height: 100.h,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.ASSEST_ADDFILE_IMAGE,
                height: 10.h),
            ElevatedButton(
             onPressed: () =>
                  controller.navigateToAddDevice(),
              style: ElevatedButton.styleFrom(
                elevation: 1.h,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12),
                ),
                backgroundColor: Color(0xffFFD700),
              ),
              child: Text(
                'addevice'.tr,
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceGridView() {
    return LiquidPullToRefresh(
      key:controller.refreshIndicatorKey,
      color: Colors.transparent,
      showChildOpacityTransition: false,
      onRefresh: () => controller.handleRefresh(),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0),
                itemCount: controller.deviceList.length,
                itemBuilder: (context, index) {
                  final device = controller.deviceList[index];
                  return _buildDeviceItem(device);
                },
              ),
            ),
          ),
        //  if (Platform.isAndroid)
            Padding(
              padding: EdgeInsets.only(left: 8.h, right: 8.h),
              child: ElevatedButton(
                child: Text(
                  'addnwdevice'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'sf',
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 1.h,
                  fixedSize: Size(100.w, 5.5.h),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.h),
                  ),
                  backgroundColor: Color(0xff304B5E),
                ),
                onPressed: () => controller.navigateToAddDevice(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(dynamic device) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
           // Get.to(() => HomeDeviceDetails(device.id, device.device, device));
          },
          child: Container(
            width: 100.h,
            decoration: BoxDecoration(
              color: Color(0xff304B5E),
              borderRadius: BorderRadius.circular(1.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  controller.assetsimg(device['icon']),
                  height: 8.h,
                  width: 8.w,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
                  child: Text(
                    '${device['device']}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins',
                        fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

 /*
  void _showEditDeviceDialog(dynamic device) {
    controller.first.text = device['device']!;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.h),
        ),
        title: Text(
          'edtdevicenme'.tr,
          style: TextStyle(fontSize: 14),
        ),
        content: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(1.h)),
          child: TextField(
            controller: controller.first,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(1.h),
              hintText: '',
              hintStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.grey,
                  fontSize: 10),
            ),
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'poppins',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'cancel'.tr,
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () => controller.handleDeviceEdit(
                device['id'].toString(), controller.first.text),
            child: Text(
              'submit'.tr,
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }*/


}