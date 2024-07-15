import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_flutter_module/framework/controller/home/home_controller.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_assets.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/text_style.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class SharePosterDetailsMobile extends ConsumerStatefulWidget {
  const SharePosterDetailsMobile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationMobileState();
}

class _AuthenticationMobileState extends ConsumerState<SharePosterDetailsMobile> {
  final GlobalKey myWidgetKey = GlobalKey();

  ///Init Override
  @override
  void initState() {
    super.initState();
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfiguration(context);
    final homeProviderWatch = ref.watch(homeProvider);
    return Scaffold(
      appBar: CommonAppBar(
        isFromHome: true,
        backgroundColor: Colors.transparent,
        onLeadingPress: () {
          try {
            ref.read(navigationStackProvider).pop();
          } catch (e) {
            printData(e);
          }
        },
      ),
      backgroundColor: AppColors.white,
      body: _bodyWidget(homeProviderWatch),
      bottomNavigationBar: _bottomNavigationWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget(HomeController homeProviderWatch) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Lottie.asset(AppAssets.lottieParticals),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(AppAssets.lottieParticals),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText(
              title: LocalizationStrings.keyYey.toLowerCase().capsFirstLetterOfSentence,
              textStyle: TextStyles.bold.copyWith(
                fontSize: 22.sp,
                color: AppColors.black,
              ),
            ).paddingOnly(bottom: 0.h, left: 0.w, right: 0.w, top: 0.h),
            CommonText(
              title: LocalizationStrings.keyYeyHas,
              textStyle: TextStyles.bold.copyWith(
                fontSize: 22.sp,
                color: AppColors.black,
              ),
            ).paddingOnly(bottom: 20.h, left: 0.w, right: 0.w, top: 6.h),
            RepaintBoundary(
              key: myWidgetKey,
              child:
                  posterImageTextWidget(homeProviderWatch).paddingOnly(bottom: 0.h, left: 16.w, right: 16.w, top: 0.h),
            ),
            bottomBarWidget(homeProviderWatch)
          ],
        )
      ],
    );
  }

  ///Bottom bar widget
  Widget bottomBarWidget(HomeController homeProviderWatch) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            try {
              Uint8List bytes = await captureWidget();
              String base64String = base64Encode(bytes);
              final homeProviderWatch = ref.watch(homeProvider);
              String shareType = "wats";
              // js.context.callMethod("DownloadBanner", [base64String, homeProviderWatch.poster!.fileName, shareType]);
            } catch (e) {
              printData("...error at share...$e");
            }
          },
          child: customShareWidget(LocalizationStrings.keyWhatsapp, AppAssets.svgWhatsapp),
        ),
        //const Spacer(),
        InkWell(
          onTap: () async {
            try {
              Uint8List bytes = await captureWidget();
              String base64String = base64Encode(bytes);
              final homeProviderWatch = ref.watch(homeProvider);
              String shareType = "facebook";
              // js.context.callMethod("DownloadBanner", [base64String, homeProviderWatch.poster!.fileName, shareType]);
            } catch (e) {
              printData("...error at share...$e");
            }
          },
          child: customShareWidget(LocalizationStrings.keyFacebook, AppAssets.svgFacebook),
        ),
        //const Spacer(),
        InkWell(
          onTap: () async {
            try {
              Uint8List bytes = await captureWidget();
              String base64String = base64Encode(bytes);
              final homeProviderWatch = ref.watch(homeProvider);
              String shareType = "download";
              // js.context.callMethod("DownloadBanner", [base64String, homeProviderWatch.poster!.fileName, shareType]);
            } catch (e) {
              printData("...error at share...$e");
            }
          },
          child: customShareWidget(LocalizationStrings.keyDownload, AppAssets.svgDownload),
        ),
        //const Spacer(),
        InkWell(
          onTap: () async {
            try {
              Uint8List bytes = await captureWidget();
              String base64String = base64Encode(bytes);
              final homeProviderWatch = ref.watch(homeProvider);
              String shareType = "other";
              // js.context.callMethod("DownloadBanner", [base64String, homeProviderWatch.poster!.fileName, shareType]);
            } catch (e) {
              printData("...error at share...$e");
            }
          },
          child: customShareWidget(LocalizationStrings.keyMore, AppAssets.svgMore),
        ),
      ],
    ).paddingOnly(bottom: 0.h, left: 20.w, right: 20.w, top: 30.h);
  }

  ///Custom Icon Widget
  Widget customShareWidget(String title, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonSVG(
          strIcon: icon,
          height: 20.h,
          width: 20.w,
        ),
        SizedBox(
          height: 10.h,
        ),
        CommonText(
          title: title,
          textStyle: TextStyles.medium.copyWith(color: AppColors.black, fontSize: 14.sp),
        )
      ],
    );
  }

  ///Get PNG bytes from Widget
  Future<Uint8List> captureWidget() async {
    final RenderRepaintBoundary boundary = myWidgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 5);

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  Widget posterImageTextWidget(HomeController homeProviderWatch) {
    return Stack(
      children: [
        /// poster image
        Container(
          height: 472.h,
          width: double.infinity,
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0, 0.57],
            ),
          ),
          /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(color: clrCFCFCF)
          ),*/
          child: Image.network(
            homeProviderWatch.poster!.signedUrl.toString(),
            errorBuilder: (context, url, error) => const Icon(Icons.error),
            //fit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 472.h,
          width: double.infinity,
          child: Stack(
            children: [
              ///offer text and Address
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 26.h, left: 16.h, right: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// offer text
                      Text(
                        homeProviderWatch.poster!.offerName.toString(),
                        style: TextStyles.txtMedium18.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      /// text line 2
                      Text(
                        homeProviderWatch.poster!.offerDesc.toString(),
                        style: TextStyles.txtRegular14.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///bottom navigation widget
  _bottomNavigationWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1.h,
          color: AppColors.clrB5B5B5,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CommonButton(
            buttonText: "Done",
            backgroundColor: AppColors.primary,
            onTap: () async {
              try {
                ref.read(navigationStackProvider).pop();
              } catch (e) {
                printData(e);
              }
            },
          ).paddingSymmetric(horizontal: globalPadding, vertical: 10.h),
        ),
      ],
    );
  }
}
