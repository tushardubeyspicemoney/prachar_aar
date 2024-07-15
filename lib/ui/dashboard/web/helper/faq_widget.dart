import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/home/home_provider.dart';
import 'package:my_flutter_module/framework/repository/banner/model/response_faq.dart';
import 'package:my_flutter_module/framework/utility/extension/string_extension.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class FaqWidgetWeb extends StatelessWidget {
  const FaqWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final homeProviderWatch = ref.watch(homeProvider);
        return homeProviderWatch.isLoading
            ? const Loader()
            : homeProviderWatch.isError
                ? Center(
                    child: Text(homeProviderWatch.errorMsg),
                  )
                : Container(
                    color: AppColors.clr0xffF5F5F8,
                    width: double.infinity,
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Key_FAQS".localized,
                            style: TextStyles.bold.copyWith(
                              fontSize: 24.sp,
                              color: AppColors.black,
                            )),
                        ListView.builder(
                            itemCount: homeProviderWatch.faq!.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              FaqItem item = homeProviderWatch.faq![index];
                              return Column(
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.h),
                                          child: Container(
                                            height: 6.h,
                                            width: 6.h,
                                            decoration:
                                                const BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        Expanded(
                                          child: Text(
                                            item.question.toString(),
                                            style: TextStyles.bold.copyWith(
                                              fontSize: 22.sp,
                                            ),
                                            selectionColor: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    collapsedIconColor: AppColors.black,
                                    collapsedTextColor: AppColors.black,
                                    iconColor: AppColors.black,
                                    tilePadding: EdgeInsets.zero,
                                    childrenPadding: EdgeInsets.zero,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                                child: Text(
                                              item.answer.toString(),
                                              style: TextStyles.regular.copyWith(
                                                fontSize: 20.sp,
                                                color: AppColors.black,
                                              ),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            })),
                      ],
                    ),
                  );
      },
    );
  }
}
