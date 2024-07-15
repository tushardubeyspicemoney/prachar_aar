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
import 'package:my_flutter_module/framework/utility/downloader/app_downloader.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_assets.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/text_style.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class SharePosterDetailsWeb extends ConsumerStatefulWidget {
  const SharePosterDetailsWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationWebState();
}

class _AuthenticationWebState extends ConsumerState<SharePosterDetailsWeb> {
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
    webDeviceConfiguration(context);
    final homeProviderWatch = ref.watch(homeProvider);
    return Scaffold(
      /*appBar: CommonAppBar(
        isFromHome: true,
        backgroundColor: Colors.transparent,
        onLeadingPress: () {
          ref.read(navigationStackProvider).pop();;
        },
      ),*/
      appBar: CommonAppBar(
        isLeadingEnable: true,
        centerTitle: false,
        backgroundColor: AppColors.transparent,
        iconColor: AppColors.black,
        centerWidget: const CommonSVG(
          strIcon: AppAssets.svgPrachar,
        ).alignAtCenterLeft(),
      ),
      backgroundColor: AppColors.white,
      body: _bodyWidget(homeProviderWatch),
      // bottomNavigationBar: _bottomNavigationWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget(HomeController homeProviderWatch) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 6,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //const Expanded(child: SizedBox()),
              Expanded(
                //flex: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
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
                          RepaintBoundary(
                            key: myWidgetKey,
                            child: posterImageTextWidget(homeProviderWatch),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //const Expanded(child: SizedBox()),
                              Expanded(
                                //flex: 10,
                                child: Column(
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    Lottie.asset(height: 150.h, width: 150.w, AppAssets.lottieSuccess),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CommonText(
                                      title:
                                          '${LocalizationStrings.keyYey.toLowerCase().capsFirstLetterOfSentence} ${LocalizationStrings.keyYeyHas}',
                                      textStyle: TextStyles.regular.copyWith(
                                        fontSize: 38.sp,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    CommonText(
                                      title: LocalizationStrings.KeyDownloadTu,
                                      textStyle: TextStyles.regular.copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 80.h),
                                    customIconWidget(
                                      LocalizationStrings.keyDownload,
                                      Icons.download,
                                      () async {
                                        try {
                                          Uint8List bytes = await captureWidget();
                                          final homeProviderWatch = ref.watch(homeProvider);
                                          AppDownloader.downloadImageFromBytesUnknown(
                                              bytes, homeProviderWatch.poster!.fileName!);
                                        } catch (e) {
                                          printData("...error at share...$e");
                                        }
                                      },
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Custom Icon Widget
  Widget customIconWidget(String title, IconData icon, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.red,
          ),
          CommonText(
            title: title,
            textStyle: TextStyles.txtMedium18.copyWith(
              color: AppColors.red,
            ),
          )
        ],
      ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        /// poster image
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            height: screenHeight * 0.7,
            width: screenWidth * 0.26,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                homeProviderWatch.poster!.signedUrl.toString(),
                errorBuilder: (context, url, error) => const Icon(Icons.error),
                //fit: BoxFit.cover,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(
            width: screenWidth * 0.26,
            height: screenHeight * 0.7,
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
                          style: TextStyles.txtMedium18.copyWith(color: AppColors.white, fontSize: 32.sp),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),

                        SizedBox(
                          height: 30.h,
                        ),

                        /// text line 2
                        Text(
                          homeProviderWatch.poster!.offerDesc.toString(),
                          style: TextStyles.txtRegular14.copyWith(color: AppColors.white, fontSize: 24.sp),
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
        ),
      ],
    );
  }
}
