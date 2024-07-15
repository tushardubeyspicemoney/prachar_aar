import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/text_style.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_form_field.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/app_toast.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class CreateOfferTextMobile extends ConsumerStatefulWidget {
  const CreateOfferTextMobile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextMobileState();
}

class _CreateOfferTextMobileState extends ConsumerState<CreateOfferTextMobile> {
  FocusNode inputNode = FocusNode();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final offerWatch = ref.watch(offerProvider);
      offerWatch.disposeController(isNotify: true);
      await offerWatch.getOfferTexts(ScaffoldMessenger.of(context));
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mobileDeviceConfiguration(context);
    final offerWatch = ref.watch(offerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        isLeadingEnable: true,
        title: LocalizationStrings.keyCreateAnOffer,
        onLeadingPress: () {
          try {
            ref.read(navigationStackProvider).pop();
          } catch (e) {
            printData(e);
          }
        },
      ),
      body: offerWatch.isLoading
          ? const Loader()
          : offerWatch.isError
              ? Center(
                  child: Text(offerWatch.errorMsg),
                )
              : _bodyWidget(),
      bottomNavigationBar: _bottomNavigationWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final offerWatch = ref.watch(offerProvider);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    CommonText(
                      title: LocalizationStrings.keySelectOfferText,
                      textStyle: TextStyles.bold.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Change height to full content to remove or part
                    /*SizedBox(
                        height: MediaQuery.of(context).size.height/4,
                        child: radioListWidget()),*/
                    radioListWidget(),

                    /// HIDE OR SECTION
                    dividerWidget(),
                    SizedBox(height: 20.h),
                    CommonText(
                      title: LocalizationStrings.keyEnterYourOwnTextNew,
                      textStyle: TextStyles.bold.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    TextField(
                      focusNode: inputNode,
                      //autofocus: true,
                      controller: offerWatch.offerTextController,
                      maxLines: 3,
                      maxLength: 40,
                      keyboardType: TextInputType.multiline,
                      //textInputAction: TextInputAction.done,
                      style: TextStyles.regular.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (offer) {
                        if (offer.toString().isNotEmpty) {
                          offerWatch.updateIsButtonEnabled(true);
                        } else {
                          offerWatch.updateIsButtonEnabled(false);
                        }
                      },

                      decoration: InputDecoration(
                          errorMaxLines: 3,
                          //enabled: isEnable ?? true,
                          counterText: '',
                          contentPadding: EdgeInsets.only(
                            left: 12.w,
                            right: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                          filled: true,
                          //label: label,
                          fillColor: AppColors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.clrB5B5B5,
                              width: 0.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 0.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          border: InputBorder.none,
                          hintText: LocalizationStrings.keyEnterYourOwnText,
                          alignLabelWithHint: true,
                          hintStyle: TextStyles.regular.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.clrB5B5B5,
                          )),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonText(
                          title: "${offerWatch.offerTextController.text.length}/40",
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    )

                    /*CommonInputFormField(
                      textEditingController: offerWatch.offerTextController,
                      rightPadding: 30.w,
                      validator: (offer) {
                        return null;
                      },
                      //focusNode: offerWatch.offerFocusNode,
                      onChanged: (offer) {
                        if (offer.toString().isNotEmpty) {
                          offerWatch.updateIsButtonEnabled(true);
                        } else {
                          offerWatch.updateIsButtonEnabled(false);
                        }
                      },
                      borderColor: AppColors.clrB5B5B5,
                      hintText: LocalizationStrings.keyEnterYourOwnText,
                      hintTextStyle: TextStyles.regular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.clrB5B5B5,
                      ),
                      maxLines: 2,
                      maxLength: 60,
                    ).paddingOnly(
                        left: globalPadding, right: globalPadding),*/
                  ],
                ).paddingOnly(left: globalPadding, right: globalPadding, bottom: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///Radio List Widget
  Widget radioListWidget() {
    final offerWatch = ref.watch(offerProvider);
    return ListView.builder(
      itemCount: offerWatch.offers!.length,
      //itemCount: offerWatch.offers!.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Radio(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: offerWatch.offers![index],
                groupValue:
                    offerWatch.currentRadioIndex != null ? offerWatch.offers![offerWatch.currentRadioIndex!] : '',
                activeColor: AppColors.primary,
                onChanged: (value) {
                  offerWatch.updateRadioValue(index);
                  FocusScope.of(context).requestFocus(inputNode);
                },
              ),
            ).paddingOnly(left: 0.w, right: 8.h),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  offerWatch.updateRadioValue(index);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: offerWatch.offers![index]!.offerDesc?.trim(),
                        style: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 15.sp),
                      ),
                    ],
                    // text: "${offerWatch.shopName} ",
                    style: TextStyles.bold.copyWith(color: AppColors.black, fontSize: 15.sp),
                  ),
                ),
              ),
            ),
          ],
        ).paddingOnly(right: 16.w, bottom: 20.h);
      },
    );
  }

  ///Divider Widget
  Widget dividerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          child: Divider(
            height: 0.8.h,
            color: AppColors.grey,
          ),
        ),
        CommonText(
          title: LocalizationStrings.keyOr,
          textStyle: TextStyles.medium.copyWith(fontSize: 12.sp, color: AppColors.grey),
        ).paddingSymmetric(horizontal: 15.w),
        SizedBox(
          width: 70.w,
          child: Divider(
            height: 0.8.h,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  ///Contact Details Widget
  Widget contactDetailsWidget() {
    final offerWatch = ref.watch(offerProvider);
    return Container(
      color: AppColors.primaryEEF0FA,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.phone,
            size: 20.r,
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: '${LocalizationStrings.keyContactInfo}:',
                  textStyle: TextStyles.bold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.black,
                  ),
                ),
                CommonInputFormField(
                  focusNode: offerWatch.contactDetailsFocusNode,
                  readOnly: !offerWatch.isContactUsFieldEditable,
                  textEditingController: offerWatch.contactDetailsTextController,
                  leftPadding: 0,
                  rightPadding: 12.w,
                  topPadding: 0,
                  bottomPadding: 0,
                  validator: null,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  textInputType: TextInputType.multiline,
                  fieldTextStyle: TextStyles.regular.copyWith(
                    color: AppColors.black,
                    fontSize: 12.sp,
                  ),
                  maxLength: 80,
                ),
              ],
            ),
          ),

          /// Hide Edit Part
          offerWatch.isContactUsFieldEditable
              ? GestureDetector(
                  onTap: () async {
                    offerWatch.updateIsContactUsFieldEditable(!offerWatch.isContactUsFieldEditable);
                    offerWatch.contactDetailsFocusNode.requestFocus();

                    await offerWatch.editAddress(ScaffoldMessenger.of(context));
                  },
                  child: CommonText(
                    title: LocalizationStrings.keySave,
                    textStyle: TextStyles.bold.copyWith(
                      fontSize: 13.sp,
                    ),
                  ).paddingSymmetric(horizontal: 2.w, vertical: 4.h),
                )
              : GestureDetector(
                  onTap: () async {
                    offerWatch.updateIsContactUsFieldEditable(!offerWatch.isContactUsFieldEditable);
                    offerWatch.contactDetailsFocusNode.requestFocus();
                  },
                  child: CommonText(
                    title: LocalizationStrings.keyEdit,
                    textStyle: TextStyles.bold.copyWith(
                      fontSize: 13.sp,
                    ),
                  ).paddingSymmetric(horizontal: 2.w, vertical: 4.h),
                ),

          SizedBox(
            width: 10.h,
          )
        ],
      ).paddingSymmetric(horizontal: 10.w, vertical: 20.h),
    );
  }

  ///bottom navigation widget
  _bottomNavigationWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // contactDetailsWidget(),
        // SizedBox(height: 10.h,),
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CommonButton(
            buttonText: LocalizationStrings.keyNext,
            backgroundColor: AppColors.primary,
            onTap: () async {
              if (ref.read(offerProvider).offerTextController.text.length > 40) {
                AppToast.showSnackBar("Only 40 character allowed", ScaffoldMessenger.of(context));
                return;
              }
              hideKeyboard(context);
              ref.read(navigationStackProvider).push(const NavigationStackItem.offerImage());
            },
          ).paddingSymmetric(horizontal: globalPadding, vertical: 10.h),
        ),
      ],
    );
  }
}
