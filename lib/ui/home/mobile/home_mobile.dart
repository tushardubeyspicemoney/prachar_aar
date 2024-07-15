import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_provider.dart';
import 'package:my_flutter_module/framework/controller/home/home_controller.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/key_analytics.dart';
import 'package:my_flutter_module/framework/utility/app_google_analytics/user_experior.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/const/app_constants.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_appbar.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_button.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_text.dart';
import 'package:my_flutter_module/ui/widgets/list_view/offer_list_view_item.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class HomeMobile extends ConsumerStatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<HomeMobile> {
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
    mobileDeviceConfiguration(context);
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider.notifier);
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        try {
          ref.read(navigationStackProvider).pop();
        } catch (e) {
          printData(e);
        }
      },
      child: Scaffold(
        key: homeProviderRead.scaffoldKey,
        appBar: CommonAppBar(
          isFromHome: true,
          centerTitle: true,
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
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    ref.read(navigationStackProvider).push(const NavigationStackItem.faqText());
                  },
                  value: LocalizationStrings.keyPleaseEnterShopName,
                  child: CommonText(
                    title: LocalizationStrings.keyFAQS,
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
                : bodyWidget(context, homeProviderWatch, homeProviderRead),
        bottomNavigationBar: bottomButton(),
      ),
    );
  }

  Widget bodyWidget(BuildContext context, HomeController homeProviderWatch, HomeController homeProviderRead) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///SelectBannerStyle
        ///
        Container(
          margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              CommonSVG(
                strIcon: AppAssets.icBulb,
                height: 20.sp,
                width: 20.sp,
              ),
              // Image.asset(AppAssets.bulb),
              // Image.network(
              //     height: 20.sp,
              //     width: 20.sp,
              //     "https://i3.imageban.ru/out/2024/06/19/dd4c5aa672daec26d0d6b84c60974155.png"),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Note:",
                      style: TextStyles.bold.copyWith(
                        fontSize: 10.5.sp,
                        color: AppColors.black,
                      )),
                  TextSpan(
                      text: "\t Your created offers may take up to 12hrs to get approved.",
                      style: TextStyles.txtMedium12.copyWith(
                        fontSize: 10.5.sp,
                        color: AppColors.black,
                      )),
                ])),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: CommonText(
            title: LocalizationStrings.keyMyOffers,
            textStyle: TextStyles.bold.copyWith(
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
        ),

        SizedBox(
          height: 5.h,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: (homeProviderWatch.posters ?? []).length,
            separatorBuilder: (_, __) => Divider(height: 60.h),
            itemBuilder: (_, i) => OfferListViewItem(
              element: homeProviderWatch.posters![i],
              globalKey: homeProviderWatch.globalKeys[i],
              onClickDownload: () {
                print("download clicked");
                homeProviderRead.downloadImage(i);
              },
              onClickShare: () {
                print("share clicked");
                homeProviderRead.onShare(i);
              },
              onClickDelete: () {
                homeProviderRead.deleteOffer(i, context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget userBannerList(HomeController homeProviderWatch) {
    return homeProviderWatch.posters!.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: Text("No Offer Found")))
        : GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(homeProviderWatch.posters!.length, (index) {
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
                                    style: TextStyles.txtMedium12.copyWith(color: AppColors.white),
                                    textAlign: TextAlign.center,
                                    maxLines: 4,
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  /// text line 2
                                  Text(
                                    item.offerDesc.toString(),
                                    style: TextStyles.txtRegular7.copyWith(color: AppColors.white),
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
            }));
  }

  ///Bottom Button
  Widget bottomButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonButton(
        buttonText: LocalizationStrings.keyCreateAnOffer,
        backgroundColor: AppColors.primary,
        buttonTextStyle: TextStyles.medium.copyWith(
          fontSize: 17.sp,
          color: AppColors.white,
        ),
        onTap: () async {
          ref.read(navigationStackProvider).push(
                const NavigationStackItem.offerText(),
              );
        },
        isPrefixEnable: true,
      ),
    );
  }
}
