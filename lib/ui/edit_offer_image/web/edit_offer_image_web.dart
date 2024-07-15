import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_images.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/dashboard/web/helper/dashboard_sub_widget.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class EditOfferImageWeb extends ConsumerStatefulWidget {
  const EditOfferImageWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextWebState();
}

class _CreateOfferTextWebState extends ConsumerState<EditOfferImageWeb> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final designWatch = ref.watch(designProvider);
      //designWatch.disposeController(isNotify: true);
      designWatch.updateTitleAndSubTitle(
        ref.watch(offerProvider).offerTextController.text,
        ref.watch(offerProvider).contactDetailsTextController.text,
      );
      final homeProviderWatch = ref.watch(homeProvider);
      await homeProviderWatch.getFaq();
      await designWatch.getUserImages(false, '');
    });
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
    final designWatch = ref.watch(designProvider);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Scaffold(
              body: designWatch.isLoading
                  ? const Loader()
                  : designWatch.isError
                      ? Center(
                          child: Text(designWatch.errorMsg),
                        )
                      : _bodyWidget(),
              bottomNavigationBar: Material(
                elevation: 5,
                child: doneButton(),
              ),
            ),
          ),
          const Expanded(child: DashboardSubWidget()),
        ],
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 13,
          child: Row(
            children: [
              Expanded(
                flex: 19,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonText(
                              title: LocalizationStrings.keyChooseYourOfferBackground
                                  .toLowerCase()
                                  .capsFirstLetterOfSentence,
                              textStyle: TextStyles.bold.copyWith(
                                fontSize: 26.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Expanded(flex: 4, child: selectImageListWidget()),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              const Expanded(flex: 6, child: SizedBox()),

              ///Text with Image
              Expanded(flex: 20, child: textWithImage()),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  ///Text With Image
  Widget textWithImage() {
    final designWatch = ref.watch(designProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              designWatch.strDisplayImage,
              width: screenWidth * 0.26,
              height: screenHeight * 0.7,
              errorBuilder: (context, url, error) => const Icon(Icons.error),
              //fit: BoxFit.cover,
              fit: BoxFit.cover,
            ),
          ),

          ///gradientBottom
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CommonSVG(
                strIcon: AppAssets.gradientBottom,
                boxFit: BoxFit.fitWidth,
                width: screenWidth * 0.26,
              ),
            ),
          ),

          ///Offer Text and Offer Desc
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: screenWidth * 0.26,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: designWatch.bannerTitleTextController,
                      maxLines: 3,
                      maxLength: 110,
                      keyboardType: TextInputType.multiline,
                      style: TextStyles.medium.copyWith(
                        fontSize: 30.sp,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(
                          left: 12.w,
                          right: 12.w,
                          top: 0.h,
                          bottom: 0.h,
                        ),
                        filled: true,
                        fillColor: AppColors.transparent,
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                    TextField(
                      controller: designWatch.bannerSubTitleTextController,
                      maxLines: 2,
                      maxLength: 60,
                      keyboardType: TextInputType.multiline,
                      style: TextStyles.regular.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(
                          left: 0.w,
                          right: 12.w,
                          top: 0.h,
                          bottom: 0.h,
                        ),
                        filled: true,
                        fillColor: AppColors.transparent,
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 15.w),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Select Image List Widget
  Widget selectImageListWidget() {
    final designWatch = ref.watch(designProvider);
    return GridView.builder(
      controller: designWatch.imageListController,
      itemCount: designWatch.userImages!.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        UserImage image = designWatch.userImages![index]!;

        /// index == 0 and 1 is camera & gallery
        if (image.signedUrl.toString().toLowerCase() == "camera" ||
            image.signedUrl.toString().toLowerCase() == "gallery") {
          return GestureDetector(
            onTap: () async {

            },
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: designWatch.selectedImageIndex == index
                    ? Border.all(
                        color: AppColors.green,
                        width: 2.w,
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.clrB5B5B5,
                    ),
                  ),
                  width: 80.w,
                  height: 80.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonSVG(
                        strIcon: AppAssets.svgGallery,
                        height: 40.h,
                        width: 40.w,
                      ),
                      SizedBox(height: 10.h),
                      CommonText(
                        title: LocalizationStrings.keyGallery,
                        textStyle: TextStyles.medium.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.black.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ).paddingSymmetric(vertical: 5.h, horizontal: 5.w),
          );
        } else {
          return GestureDetector(
            onTap: () async {
              await designWatch.updateSelectedImageIndex(index);
            },
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: designWatch.selectedImageIndex == index
                    ? Border.all(
                        color: AppColors.green,
                        width: 3.w,
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.network(
                  image.signedUrl.toString(),
                  errorBuilder: (context, url, error) => const Icon(Icons.error),
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                ),
              ),
            ).paddingSymmetric(vertical: 5.h, horizontal: 5.w),
          );
        }
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisExtent: 140.h, mainAxisSpacing: 20.w, crossAxisSpacing: 20.w),
    );
  }

  Widget doneButton() {
    final designWatch = ref.watch(designProvider);
    return Padding(
      padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
      child: Row(
        children: [
          const Expanded(
            flex: 50,
            child: SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: CommonButton(
              height: MediaQuery.of(context).size.height * 0.07,
              buttonText: LocalizationStrings.keyDone,
              fontSize: 24.sp,
              borderRadius: BorderRadius.circular(5.r),
              onTap: () async {
                hideKeyboard(context);

                //print("....index at Next Button....${dashboardWatch.currentTabIndex}");
                await designWatch.saveAndShare(ref, ScaffoldMessenger.of(context), true);
              },
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ).paddingOnly(bottom: 40.h),
    );
  }
}
