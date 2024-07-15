import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_controller.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/framework/utility/extension/extension.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class HomeWeb extends ConsumerStatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends ConsumerState<HomeWeb> {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final homeProviderWatch = ref.watch(homeProvider);
      await homeProviderWatch.getPosterList();
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
    final homeProviderWatch = ref.watch(homeProvider);
    return Scaffold(
      appBar: CommonAppBar(
        isFromHome: true,
        elevation: 1,
        centerWidget: const CommonSVG(
          strIcon: AppAssets.svgPrachar,
        ),
        backgroundColor: AppColors.white,
        onLeadingPress: () {
          try {
            ref.read(navigationStackProvider).pop();
          } catch (e) {
            printData(e);
          }
        },
        actions: [
          PopupMenuButton<String>(
            onSelected: (item) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            offset: Offset(-20.w, kToolbarHeight),
            icon: const CommonSVG(
              strIcon: AppAssets.svgMore,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              /*PopupMenuItem<String>(
                value: LocalizationStrings.keyUpdateContactDetails,
                child: CommonText(
                  title: LocalizationStrings.keyUpdateContactDetails,
                ),
              ),*/
              PopupMenuItem<String>(
                onTap: () {
                  final brandingWatch = ref.watch(brandingProvider);
                  brandingWatch.updateShopName();
                  ref.read(navigationStackProvider).push(const NavigationStackItem.updateShop());
                },
                value: LocalizationStrings.keyUpdateShopName,
                child: CommonText(
                  title: LocalizationStrings.keyUpdateShopName,
                  textStyle: TextStyles.medium.copyWith(fontSize: 24.sp),
                ),
              ),
              PopupMenuItem<String>(
                onTap: () {
                  ref.read(navigationStackProvider).push(const NavigationStackItem.faqText());
                },
                value: LocalizationStrings.keyPleaseEnterShopName,
                child: CommonText(
                  title: LocalizationStrings.keyFAQS,
                  textStyle: TextStyles.medium.copyWith(fontSize: 24.sp),
                ),
              ),
            ],
          ),
        ],
      ),
      body: homeProviderWatch.isLoading
          ? const Loader()
          : homeProviderWatch.isError
              ? Center(child: Text(homeProviderWatch.errorMsg))
              : _bodyWidget(context, homeProviderWatch),
      floatingActionButton: bottomButton(),
    );
  }

  Widget _bodyWidget(BuildContext context, HomeController homeProviderWatch) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///SelectBannerStyle
                  CommonText(
                    title: LocalizationStrings.keyMyOffers,
                    textStyle: TextStyles.bold.copyWith(
                      fontSize: 26.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  userBannerList(homeProviderWatch)
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget userBannerList(HomeController homeProviderWatch) {
    return homeProviderWatch.posters!.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: Text("No Offer Found")))
        : _getGridView(homeProviderWatch);
  }

  ///Bottom Button
  // Widget bottomButton() {
  //   return CommonButton(
  //     width: MediaQuery.of(context).size.width * 0.2,
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     buttonText: LocalizationStrings.keyCreateAnOffer,
  //     backgroundColor: AppColors.primary,
  //     borderRadius: BorderRadius.circular(22.r),
  //     buttonTextStyle: TextStyles.medium.copyWith(
  //       fontSize: 24.sp,
  //       color: AppColors.white,
  //     ),
  //     onTap: () async {
  //       ref.read(navigationStackProvider).push(
  //             const NavigationStackItem.offerText(),
  //           );
  //     },
  //     isPrefixEnable: true,
  //   );
  // }
  Widget bottomButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () {
        ref.read(navigationStackProvider).push(
              const NavigationStackItem.offerText(),
            );
      },
      child: const Icon(Icons.add),
    ).paddingOnly(right: 20.w);
  }

  Widget _getGridView(homeProviderWatch) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 20.h,
      crossAxisSpacing: 20.w,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        homeProviderWatch.posters!.length,
        (index) {
          Poster item = homeProviderWatch.posters![index];
          return InkWell(
            onTap: () async {
              await homeProviderWatch.updateUserPosterItem(item);
              await UserExperior.addEvent(KeyAnalytics.keyPosterDetails, "", KeyAnalytics.keyTypeEvent);
              ref.read(navigationStackProvider).push(const NavigationStackItem.posterDetails());
            },
            child: Stack(
              children: [
                /// poster image
                Container(
                  height: double.infinity,
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h), border: Border.all(color: AppColors.clrCFCFCF)),
                  child: Image.network(
                    item.signedUrl.toString(),
                    errorBuilder: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  //height: 472.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ///offer text and Address
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12.h, left: 4.h, right: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// offer text
                              Text(
                                item.offerName.toString(),
                                style: TextStyles.txtMedium23.copyWith(color: AppColors.white),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),

                              SizedBox(
                                height: 40.h,
                              ),

                              /// text line 2
                              Text(
                                item.offerDesc.toString(),
                                style: TextStyles.txtRegular14.copyWith(color: AppColors.white, fontSize: 18.sp),
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
            ),
          );
        },
      ),
    );
  }
}
