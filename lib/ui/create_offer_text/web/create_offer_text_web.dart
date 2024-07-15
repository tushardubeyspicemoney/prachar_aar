import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/dashboard/web/helper/dashboard_sub_widget.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_form_field.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class CreateOfferTextWeb extends ConsumerStatefulWidget {
  const CreateOfferTextWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateOfferTextWebState();
}

class _CreateOfferTextWebState extends ConsumerState<CreateOfferTextWeb> {
  FocusNode inputNode = FocusNode();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final offerWatch = ref.watch(offerProvider);
      offerWatch.disposeController(isNotify: true);
      final homeProviderWatch = ref.watch(homeProvider);
      await homeProviderWatch.getFaq();
      await offerWatch.getOfferTexts(ScaffoldMessenger.of(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    webDeviceConfiguration(context);
    final offerWatch = ref.watch(offerProvider);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Scaffold(
              appBar: CommonAppBar(
                isLeadingEnable: true,
                centerTitle: false,
                backgroundColor: AppColors.transparent,
                iconColor: AppColors.black,
                centerWidget: const CommonSVG(
                  strIcon: AppAssets.svgPrachar,
                ).alignAtCenterLeft(),
              ),
              resizeToAvoidBottomInset: true,
              body: offerWatch.isLoading
                  ? const Loader()
                  : offerWatch.isError
                      ? Center(
                          child: Text(offerWatch.errorMsg),
                        )
                      : _bodyWidget(),
              bottomNavigationBar: Material(
                elevation: 5,
                child: nextButtonWidget(),
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
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Expanded(
          flex: 25,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              title: LocalizationStrings.keySelectOfferText,
                              textStyle: TextStyles.bold.copyWith(
                                fontSize: 26.sp,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Expanded(child: radioListWidget()),
                          ],
                        )),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: dividerWidget(),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: enterYourOfferText(),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: contactDetailsWidget(),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Enter your offer
  Widget enterYourOfferText() {
    final offerWatch = ref.watch(offerProvider);
    return TextField(
      focusNode: inputNode,
      controller: offerWatch.offerTextController,
      maxLines: 6,
      maxLength: 110,
      keyboardType: TextInputType.multiline,
      //textInputAction: TextInputAction.done,
      style: TextStyles.regular.copyWith(
        fontSize: 24.sp,
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
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: 20.h,
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
              color: AppColors.clrB5B5B5,
              width: 0.5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(7.r),
          ),
          border: InputBorder.none,
          hintText: LocalizationStrings.keyEnterYourOwnText,
          alignLabelWithHint: true,
          hintStyle: TextStyles.regular.copyWith(
            fontSize: 24.sp,
            color: AppColors.clrB5B5B5,
          )),
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
                },
              ),
            ).paddingOnly(left: 0.w, right: 8.h),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  offerWatch.updateRadioValue(index);
                  FocusScope.of(context).requestFocus(inputNode);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: offerWatch.offers![index]!.offerDesc?.trim(),
                        style: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 22.sp),
                      ),
                    ],
                    // text: "${offerWatch.shopName} ",
                    style: TextStyles.bold.copyWith(color: AppColors.black, fontSize: 22.sp),
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
          width: 170.w,
          child: Divider(
            height: 0.8.h,
            color: AppColors.grey,
          ),
        ),
        CommonText(
          title: LocalizationStrings.keyOr,
          textStyle: TextStyles.medium.copyWith(fontSize: 24.sp, color: AppColors.grey),
        ).paddingSymmetric(horizontal: 15.w),
        SizedBox(
          width: 170.w,
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
      decoration: const BoxDecoration(
        color: AppColors.primaryEEF0FA,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.phone,
            size: 30.r,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: '${LocalizationStrings.keyContactInfo}:',
                  textStyle: TextStyles.bold.copyWith(
                    fontSize: 24.sp,
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
                    fontSize: 24.sp,
                  ),
                  maxLength: 80,
                ),
              ],
            ),
          ),
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
                      fontSize: 20.sp,
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
                      fontSize: 20.sp,
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

  ///Widget Next Button Widget
  Widget nextButtonWidget() {
    final offerWatch = ref.watch(offerProvider);
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
              buttonText: LocalizationStrings.keyNext,
              fontSize: 24.sp,
              borderRadius: BorderRadius.circular(5.r),
              backgroundColor: offerWatch.isButtonEnabled ? AppColors.primary : AppColors.primary.withOpacity(0.2),
              onTap: () async {
                if (offerWatch.isButtonEnabled) {
                  hideKeyboard(context);
                  ref.read(navigationStackProvider).push(const NavigationStackItem.offerImage());
                } else {
                  showCustomSnackBar(LocalizationStrings.keyPleaseEnterOfferText, context);
                }
              },
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          )
        ],
      ).paddingOnly(bottom: 40.h),
    );
  }
}
