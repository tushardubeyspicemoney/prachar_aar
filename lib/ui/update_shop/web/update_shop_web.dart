import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_form_field.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

import '../../utils/theme/theme.dart';

class UpdateShopWeb extends ConsumerStatefulWidget {
  const UpdateShopWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateShopWeb> createState() => _UpdateShopWebState();
}

class _UpdateShopWebState extends ConsumerState<UpdateShopWeb> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final shopTypeWatch = ref.watch(shopTypeProvider);
      // shopTypeWatch.disposeController(isNotify: true);
      await shopTypeWatch.getIndustryList(true);
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
    final shopTypeWatch = ref.watch(shopTypeProvider);
    return Scaffold(
      body: shopTypeWatch.isLoading
          ? const Loader()
          : shopTypeWatch.isError
              ? Center(
                  child: Text(shopTypeWatch.errorMsg),
                )
              : _bodyWidget(),
      floatingActionButton: nextButtonWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final brandingWatch = ref.watch(brandingProvider);
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              CommonText(
                title: LocalizationStrings.keyWhatIsYourShopName.toLowerCase().capsFirstLetterOfSentence,
                textStyle: TextStyles.bold.copyWith(
                  fontSize: 26.sp,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 40.h),
              CommonInputFormField(
                textEditingController: brandingWatch.companyNameTextController,
                validator: null,
                focusNode: brandingWatch.companyNameFocus,
                onChanged: (companyName) {
                  if (companyName.toString().isEmpty) {
                    brandingWatch.updateIsButtonEnabled(false);
                  } else {
                    brandingWatch.updateIsButtonEnabled(true);
                  }
                },
                borderColor: AppColors.primary,
                borderWidth: 1.w,
                fieldTextStyle: TextStyles.regular.copyWith(fontSize: 22.sp, color: AppColors.black),
                label: CommonText(
                  title: LocalizationStrings.keyEnterShopName,
                  textStyle: TextStyles.regular.copyWith(fontSize: 22.sp),
                ),
              ),
              SizedBox(height: 40.h),
              Expanded(
                flex: 1,
                child: CommonText(
                  title: LocalizationStrings.keySelectShopType.toLowerCase().capsFirstLetterOfSentence,
                  textStyle: TextStyles.bold.copyWith(
                    fontSize: 26.sp,
                    color: AppColors.black,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 13,
                child: GridView.builder(
                  itemCount: ref.watch(shopTypeProvider).industriesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return gridListWidget(index);
                  },
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, mainAxisExtent: 190.h, mainAxisSpacing: 20.h, crossAxisSpacing: 20.w),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///Grid List Widget
  Widget gridListWidget(int index) {
    final shopTypeWatch = ref.watch(shopTypeProvider);
    //ShopTypeModel shopTypeModel = shopTypeWatch.shopList[index];
    Industry item = shopTypeWatch.industriesList![index];
    return GestureDetector(
      onTap: () {
        shopTypeWatch.updateSelectedIndex(index);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: shopTypeWatch.selectedIndex != null
                    ? shopTypeWatch.selectedIndex == index
                        ? AppColors.green
                        : AppColors.clrB5B5B5
                    : AppColors.clrB5B5B5,
                width: shopTypeWatch.selectedIndex != null
                    ? shopTypeWatch.selectedIndex == index
                        ? 2.w
                        : 1.w
                    : 1.w,
              ),
            ),
            height: 190.h,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    item.industryImage.toString(),
                    height: 80.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Container(
                      height: 80.h,
                      width: 80.w,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.error,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CommonText(
                    title: item.industryName.toString(),
                    textStyle: TextStyles.regular.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          shopTypeWatch.selectedIndex != null
              ? shopTypeWatch.selectedIndex == index
                  ? Positioned(
                      right: 20,
                      top: 10,
                      child: Container(
                        height: 20.w,
                        width: 20.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.green),
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.green,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.done,
                            color: AppColors.white,
                            size: 15.r,
                          ),
                        ),
                      ),
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }

  ///Widget Next Button Widget
  Widget nextButtonWidget() {
    final shopTypeWatch = ref.watch(shopTypeProvider);
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
              fontSize: 24.sp,
              borderRadius: BorderRadius.circular(5.r),
              buttonText: LocalizationStrings.keyProceed,
              backgroundColor: AppColors.primary,
              onTap: () async {
                final brandingWatch = ref.watch(brandingProvider);
                if (brandingWatch.companyNameTextController.text.isEmpty) {
                  showCustomSnackBar(LocalizationStrings.keyEnterShopName, context);
                } else {
                  await shopTypeWatch.updateIndustryV2(ref, true);
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
