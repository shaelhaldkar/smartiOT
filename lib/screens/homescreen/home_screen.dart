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
          backgroundColor: App_colors.primaryHeader,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: FloatingActionButton(
              backgroundColor: App_colors.floatingButton,
              onPressed: () => controller.navigateToAddDevice(),
              child: Icon(Icons.add,color: App_colors.txtwhite),
            ),
          ),

          body: WillPopScope(
            onWillPop: () => Helpers.showExitDialog(context),
            child: Column(
              children: [
                Container(
                  height: 10.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal:4.w),
                  decoration: BoxDecoration(
                    color: App_colors.primaryHeader,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height:5.h,
                            width:5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: App_colors.bg_black,
                            ),
                          ),

                          SizedBox(width:10),
                          Obx(
                            ()=> Text(
                              "${"welcome_mady".tr}\n${controller.username.value}",
                              style: TextStyle(
                                color: App_colors.txtwhite,
                                fontSize:16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily:'poppins',
                              ),
                            ),
                          ),

                        ],
                      ),
                      IconButton(
                        onPressed: () => controller.dologout(),
                        icon: Icon(Icons.logout_rounded,color: App_colors.txtwhite),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 1.h),
                    width: double.infinity,
                    padding: EdgeInsets.only(top:3.h,left:4.w,right:4.w),
                    decoration: BoxDecoration(
                      color: App_colors.pageBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: _buildDeviceList(),
                  ),
                ),
              ],
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
      } else {
        return _buildDeviceGridView();
      }
    });
  }

  Widget _buildDeviceGridView() {
    return LiquidPullToRefresh(
      key: controller.refreshIndicatorKey,
      color: Colors.blue,
      showChildOpacityTransition: false,
      onRefresh: () => controller.handleRefresh(),
      child: GridView.builder(
        itemCount: controller.deviceList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          crossAxisSpacing:4.w,
          mainAxisSpacing:3.h,
          childAspectRatio:1.1,
        ),
        itemBuilder:(context,index){
          final device = controller.deviceList[index];
          return _buildDeviceItem(device);
        },
      ),
    );
  }

  Widget _buildDeviceItem(dynamic device) {
    bool isNeon = controller.isNeonDevice(device);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // Get.to(() => HomeDeviceDetails(device.id, device.device, device));
          },
          child: Container(
            width: 100.h,
            decoration: BoxDecoration(
              color: App_colors.cardBackground,
              borderRadius: BorderRadius.circular(3.h),
              border: Border.all(
                color: App_colors.cardBorder,
                width: 0.4,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isNeon
                    ? Container(
                  height:8.h,
                  width:8.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: App_colors.neonGradient,
                  ),
                  child: Center(
                    child: Container(
                      height:7.h,
                      width:7.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: App_colors.neonInnerCircle,
                      ),
                    ),
                  ),
                )
                    : Container(
                  height:8.h,
                  width:8.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: App_colors.iconCircleBg,
                  ),
                  child: Icon(
                    Icons.power,
                    size: 40,
                    color: App_colors.bg_black,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text(
                    '${device['device']}',
                    style: TextStyle(
                        color: App_colors.text_primary,
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

}