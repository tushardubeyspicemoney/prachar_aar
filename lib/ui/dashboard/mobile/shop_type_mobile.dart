import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/repository/introduction/model/response_industry_list.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class ShopTypeMobile extends ConsumerStatefulWidget {
  const ShopTypeMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ShopTypeMobile> createState() => _ShopTypeMobileState();
}

class _ShopTypeMobileState extends ConsumerState<ShopTypeMobile> with AutomaticKeepAliveClientMixin {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final shopTypeWatch = ref.watch(shopTypeProvider);
      shopTypeWatch.disposeController(isNotify: true);
      await shopTypeWatch.getIndustryList(false);
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
    super.build(context);
    mobileDeviceConfiguration(context);
    final shopTypeWatch = ref.watch(shopTypeProvider);
    return shopTypeWatch.isLoading
        ? const Loader()
        : shopTypeWatch.isError
            ? Center(
                child: Text(shopTypeWatch.errorMsg),
              )
            : _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        CommonText(
          title: LocalizationStrings.keySelectShopType.toLowerCase().capsFirstLetterOfSentence,
          textStyle: TextStyles.bold.copyWith(
            fontSize: 22.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 30.h),
        Expanded(
          child: GridView.builder(
            itemCount: ref.watch(shopTypeProvider).industriesList!.length,
            itemBuilder: (BuildContext context, int index) {
              return gridListWidget(index);
            },
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 140.h, mainAxisSpacing: 20.h, crossAxisSpacing: 20.h),
          ),
        )
      ],
    ).paddingSymmetric(horizontal: globalPadding);
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
            height: 140.h,
            width: 150.w,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    item.industryImage.toString(),
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Container(
                      height: 50.h,
                      width: 50.w,
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
                      fontSize: 14.sp,
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

  @override
  bool get wantKeepAlive => true;
}
