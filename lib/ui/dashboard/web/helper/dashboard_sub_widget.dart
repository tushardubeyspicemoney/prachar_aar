import 'package:my_flutter_module/ui/dashboard/web/helper/faq_widget.dart';
import 'package:my_flutter_module/ui/dashboard/web/helper/tutorial_widget.dart';
import 'package:my_flutter_module/ui/utils/theme/theme.dart';

class DashboardSubWidget extends StatelessWidget {
  const DashboardSubWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const VerticalDivider(
          width: 1,
          thickness: 1,
          color: AppColors.lightGrey,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          const TutorialWidget(),
                          SizedBox(height: 40.h),
                          const FaqWidgetWeb(),
                        ],
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
