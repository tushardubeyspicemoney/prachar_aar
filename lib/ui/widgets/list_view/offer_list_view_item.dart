import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';
import 'package:my_flutter_module/ui/utils/theme/app_strings.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_svg.dart';

class OfferListViewItem extends StatelessWidget {
  final Poster element;
  final Function onClickDownload;
  final Function onClickShare;
  final Function onClickDelete;
  final GlobalKey<State<StatefulWidget>> globalKey;

  const OfferListViewItem({
    super.key,
    required this.element,
    required this.onClickDownload,
    required this.onClickShare,
    required this.onClickDelete,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRejected = element.status == 2;
    final bool isPending = element.status == 0;
    // final bool isRejected = true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepaintBoundary(
          key: globalKey,
          child: Container(
            width: double.maxFinite,
            height: 131.h,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(element.imageUrl ?? "")),
              color: Colors.white,
            ),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                    child: Row(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                              child: Text(
                                element.offerName.toString(),
                                style: TextStyles.txtMedium16
                                    .copyWith(color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                              child: Text(
                                _getShopDetail(),
                                style: TextStyles.txtMedium12.copyWith(color: AppColors.white.withOpacity(0.5)),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  color: Colors.grey.withOpacity(isRejected || isPending ? 0.7 : 0),
                )),
                if (element.status == 0)
                  Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, top: 3, bottom: 2, right: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 11.sp,
                              width: 11.sp,
                              child: const CommonSVG(strIcon: AppAssets.icLoader),
                            ),
                            // Image.asset(AppAssets.featherLoader),
                            // Image.network("https://i2.imageban.ru/out/2024/06/19/59f0c7f78cb8bbe3bf8ec28dc1ef619a.png"),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              LocalizationStrings.keyUnderVerification,
                              style: TextStyles.txtRegular10
                                  .copyWith(color: AppColors.white, fontSize: 11.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )),
                if (isRejected == true) Positioned.fill(child: Center(child: Image.asset(AppAssets.redRejected)))
              ],
            ),
          ),
        ),
        if (isPending != true) SizedBox(height: 13.h),
        if (isPending != true)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16.w),
              if (isRejected != true)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: CustomOutlineButton(
                    text: LocalizationStrings.keyDownload,
                    iconData: Icons.download,
                    onClick: () {
                      onClickDownload();
                    },
                  ),
                ),
              if (isRejected != true)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: CustomOutlineButton(
                    text: LocalizationStrings.keyShare,
                    iconData: Icons.share,
                    onClick: () {
                      onClickShare();
                    },
                  ),
                ),
              /* CustomOutlineButton(text: LocalizationStrings.keyEdit,
              iconData: Icons.edit,
              onClick: () {
                onClickDownload();
              },),*/
              CustomOutlineButton(
                text: "Delete",
                iconData: Icons.delete,
                onClick: () {
                  showDialog(
                    context: context,
                    builder: (con) {
                      return AlertDialog(
                        content: Text(
                          "Are you sure you want to delete the banner?",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomOutlineButton(
                                  text: "No",
                                  onClick: () => Navigator.pop(con),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: CustomOutlineButton(
                                  text: "Yes",
                                  isFilled: true,
                                  onClick: () {
                                    Navigator.pop(con);
                                    onClickDelete();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(width: 16.w),
            ],
          ),
      ],
    );
  }

  String _getShopDetail() {
    try {
      String text = element.offerDesc.toString().replaceAll("Call ", "");
      text = text.replaceAll("91", "+91-");
      return text;
    } catch (e) {
      print("error -> $e");
    }
    return "";
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final IconData? iconData;
  final bool isFilled;

  const CustomOutlineButton({
    super.key,
    required this.text,
    this.iconData,
    this.isFilled = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          color: isFilled ? AppColors.borderPrimary : null,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppColors.borderPrimary),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        child: iconData == null
            ? Text(
                text,
                style: TextStyle(fontSize: 12.sp, color: isFilled ? AppColors.white : AppColors.borderPrimary),
              )
            : Row(
                children: [
                  Icon(iconData, size: 16.sp, color: const Color(0xFF293897)),
                  SizedBox(width: 8.w),
                  Text(
                    text,
                    style: TextStyle(fontSize: 12.sp, color: isFilled ? AppColors.white : AppColors.borderPrimary),
                  ),
                ],
              ),
      ),
    );
  }
}
