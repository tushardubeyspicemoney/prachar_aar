import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_controller.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/framework/utility/downloader/app_downloader.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/text_style.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class PosterDetailsWeb extends ConsumerStatefulWidget {
  const PosterDetailsWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationWebState();
}

class _AuthenticationWebState extends ConsumerState<PosterDetailsWeb> {
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
      appBar: CommonAppBar(
        backgroundColor: Colors.transparent,
        onLeadingPress: () {
          ref.read(navigationStackProvider).pop();
          ;
        },
      ),
      backgroundColor: AppColors.black343434,
      body: _bodyWidget(homeProviderWatch),
      bottomNavigationBar: bottomBarWidget(ref),
    );
  }

  ///Body Widget
  Widget _bodyWidget(HomeController homeProviderWatch) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: myWidgetKey,
                child: posterImageTextWidget(homeProviderWatch),
              )
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Bottom bar widget
  Widget bottomBarWidget(WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customIconWidget(
          LocalizationStrings.keyEdit,
          Icons.edit,
          () async {
            //homeProviderWatch.poster!.signedUrl.toString()
            final offerWatch = ref.watch(offerProvider);
            final homeProviderWatch = ref.watch(homeProvider);
            await offerWatch.updateTextEdit(homeProviderWatch.poster!);
            ref.read(navigationStackProvider).push(const NavigationStackItem.editOfferText());
          },
        ),
        /*customIconWidget(
          LocalizationStrings.keyShare,
          Icons.share,
              () async{
            await UserExperior.addEvent(KeyAnalytics.keyShareWats, "", KeyAnalytics.keyTypeEvent);
            try
            {
              final homeProviderWatch = ref.watch(homeProvider);
              Uint8List bytes = await captureWidget();

              AppDownloader.downloadImageFromBytesUnknown(bytes, homeProviderWatch.poster!.fileName!);


              //String base64String = base64Encode(bytes);
              //final homeProviderWatch = ref.watch(homeProvider);
              //String shareType="other";
              //js.context.callMethod("DownloadBanner",[base64String,homeProviderWatch.poster!.fileName,shareType]);
            }
            catch(e)
            {
              printData("...error at share...$e");
            }


          },
        ),*/
        customIconWidget(
          LocalizationStrings.keyDownload,
          Icons.download,
          () async {
            await UserExperior.addEvent(KeyAnalytics.keyShareWats, "", KeyAnalytics.keyTypeEvent);
            try {
              Uint8List bytes = await captureWidget();
              //String base64String = base64Encode(bytes);
              final homeProviderWatch = ref.watch(homeProvider);
              //String shareType="download";
              //js.context.callMethod("DownloadBanner",[base64String,homeProviderWatch.poster!.fileName,shareType]);
              AppDownloader.downloadImageFromBytesUnknown(bytes, homeProviderWatch.poster!.fileName!);
            } catch (e) {
              printData("...error at share...$e");
            }
          },
        ),
      ],
    ).paddingOnly(bottom: 30.h, left: 50.w, right: 50.w);
  }

  ///Custom Icon Widget
  Widget customIconWidget(String title, IconData icon, VoidCallback? onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
        CommonText(
          title: title,
          textStyle: TextStyles.medium.copyWith(
            color: AppColors.white,
          ),
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
        Container(
          height: screenHeight * 0.8,
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
          child: Image.network(
            homeProviderWatch.poster!.signedUrl.toString(),
            errorBuilder: (context, url, error) => const Icon(Icons.error),
            //fit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.26,
          height: screenHeight * 0.8,
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

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.network(
            homeProviderWatch.poster!.signedUrl.toString(),
            errorBuilder: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
