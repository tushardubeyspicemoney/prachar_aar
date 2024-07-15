import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/dashboard/design_controller.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_images.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class EditOfferImageMobile extends ConsumerStatefulWidget {
  const EditOfferImageMobile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextMobileState();
}

class _CreateOfferTextMobileState extends ConsumerState<EditOfferImageMobile> {
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
      await designWatch.getUserImages(true, ref.watch(offerProvider).editPosterItem!.imageUrl.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final designWatch = ref.watch(designProvider);
    mobileDeviceConfiguration(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keyCreateAnOffer,
      ),
      body: designWatch.isLoading
          ? const Loader()
          : designWatch.isError
              ? Center(
                  child: Text(designWatch.errorMsg),
                )
              : _bodyWidget(),
      bottomNavigationBar: _bottomNavigationWidget(designWatch),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final designWatch = ref.watch(designProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          CommonText(
            title: LocalizationStrings.keyChooseYourOfferBackground.toLowerCase().capsFirstLetterOfSentence,
            textStyle: TextStyles.bold.copyWith(
              fontSize: 22.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 30.h),

          ///Text with Image
          Stack(
            children: [
              /// Image
              Image.network(
                designWatch.strDisplayImage,
                width: 345.w,
                height: 425.h,
                errorBuilder: (context, url, error) => const Icon(Icons.error),
                //fit: BoxFit.cover,
                fit: BoxFit.cover,
              ),

              ///gradientBottom
              Positioned(
                bottom: 0,
                child: CommonSVG(
                  strIcon: AppAssets.gradientBottom,
                  boxFit: BoxFit.fitWidth,
                  width: 345.w,
                ),
              ),

              ///Offer Text and Offer Desc
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 130.h,
                  width: 345.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*CommonInputFormField(
                        textEditingController:
                        designWatch.bannerTitleTextController,
                        fieldTextStyle: TextStyles.medium.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                        topPadding: 0,
                        bottomPadding: 0,
                        maxLines: 2,
                        validator: null,
                      ),*/

                      TextField(
                        controller: designWatch.bannerTitleTextController,
                        maxLines: 4,
                        maxLength: 110,
                        keyboardType: TextInputType.multiline,
                        style: TextStyles.medium.copyWith(
                          fontSize: 18.sp,
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

                      /*CommonInputFormField(
                        textEditingController:
                        designWatch.bannerSubTitleTextController,
                        textAlign: TextAlign.center,
                        fieldTextStyle: TextStyles.regular.copyWith(
                          fontSize: 11.sp,
                          color: AppColors.white,
                        ),
                        topPadding: 0,
                        bottomPadding: 0,
                        maxLines: 2,
                        validator: null,
                      )*/

                      TextField(
                        controller: designWatch.bannerSubTitleTextController,
                        maxLines: 2,
                        //maxLength: 60,
                        keyboardType: TextInputType.multiline,
                        style: TextStyles.regular.copyWith(
                          fontSize: 11.sp,
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
              )
            ],
          ).paddingSymmetric(horizontal: 10.w),

          /// Images List
          SizedBox(height: 20.h),
          //selectImageListWidget()
        ],
      ).paddingSymmetric(horizontal: globalPadding),
    );
  }

  ///Select Image List Widget
  Widget selectImageListWidget() {
    final designWatch = ref.watch(designProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            controller: designWatch.imageListController,
            itemCount: designWatch.userImages!.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
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
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 10.h),
                            CommonText(
                              title: LocalizationStrings.keyGallery,
                              textStyle: TextStyles.medium.copyWith(
                                fontSize: 12.sp,
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
                    child: Image.network(
                      image.signedUrl.toString(),
                      errorBuilder: (context, url, error) => const Icon(Icons.error),
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ).paddingSymmetric(vertical: 5.h, horizontal: 5.w),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  ///bottom navigation widget
  _bottomNavigationWidget(DesignController designWatch) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        selectImageListWidget(),
        SizedBox(height: 20.h),
        Divider(
          height: 1.h,
          color: AppColors.clrB5B5B5,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CommonButton(
            buttonText: LocalizationStrings.keyDone,
            backgroundColor: AppColors.primary,
            onTap: () async {
              hideKeyboard(context);
              //ref.read(navigationStackProvider).push(const NavigationStackItem.offerImage());
              await designWatch.editPoster(
                  ref, ScaffoldMessenger.of(context), ref.watch(offerProvider).editPosterItem!.bannersId);
            },
          ).paddingSymmetric(horizontal: globalPadding, vertical: 10.h),
        ),
      ],
    );
  }
}
