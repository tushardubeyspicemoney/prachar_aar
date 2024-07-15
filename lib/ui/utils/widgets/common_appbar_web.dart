import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';

class CommonAppBarWeb extends StatelessWidget implements PreferredSizeWidget {
  final bool isFromHome;
  final bool isLeadingEnable;
  final bool isDrawerEnable;
  final bool? centerTitle;
  final GestureTapCallback? onLeadingPress;
  final GestureTapCallback? onDrawerClicked;
  final String title;
  final String? leftImage;
  final List<Widget>? actions;
  final Widget? centerWidget;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;

  const CommonAppBarWeb({
    Key? key,
    this.isFromHome = false,
    this.isLeadingEnable = true,
    this.isDrawerEnable = false,
    this.onLeadingPress,
    this.leftImage,
    this.title = '',
    this.backgroundColor,
    this.titleColor,
    this.actions,
    this.onDrawerClicked,
    this.centerWidget,
    this.centerTitle,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AppBar(
          centerTitle: centerTitle ?? false,
          leading: isLeadingEnable
              ? IconButton(
                  onPressed: onLeadingPress ??
                      () {
                        ref.read(navigationStackProvider).pop();
                        ;
                      },
                  icon: Icon(
                    Icons.arrow_back,
                    color: isFromHome ? AppColors.black : AppColors.black,
                  ),
                )
              : const Offstage(),
          elevation: elevation ?? 0,
          actions: actions,
          backgroundColor: backgroundColor ?? AppColors.primary,
          title: centerWidget ??
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyles.medium.copyWith(color: titleColor ?? AppColors.black, fontSize: 16)),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

/*
Widget Usage
const CommonAppBar(
        title: "Home",
      ),
* */
