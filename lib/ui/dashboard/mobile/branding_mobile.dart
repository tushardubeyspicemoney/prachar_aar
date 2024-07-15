import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_form_field.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';

class BrandingMobile extends ConsumerStatefulWidget {
  const BrandingMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<BrandingMobile> createState() => _BrandingMobileState();
}

class _BrandingMobileState extends ConsumerState<BrandingMobile> with AutomaticKeepAliveClientMixin {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final brandingWatch = ref.watch(brandingProvider);
      brandingWatch.disposeController(isNotify: true);
      brandingWatch.companyNameFocus.requestFocus();
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
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final brandingWatch = ref.watch(brandingProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        CommonText(
          title: LocalizationStrings.keyWhatIsYourShopName.toLowerCase().capsFirstLetterOfSentence,
          textStyle: TextStyles.bold.copyWith(
            fontSize: 22.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 25.h),
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
          label: CommonText(
            title: LocalizationStrings.keyEnterShopName,
            textStyle: TextStyles.regular.copyWith(fontSize: 12.sp),
          ),
        )
      ],
    ).paddingSymmetric(horizontal: globalPadding);
  }

  @override
  bool get wantKeepAlive => true;
}
