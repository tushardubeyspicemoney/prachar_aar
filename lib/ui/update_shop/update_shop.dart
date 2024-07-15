import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/update_shop/mobile/update_shop_mobile.dart';
import 'package:my_flutter_module/ui/update_shop/web/update_shop_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UpdateShop extends ConsumerStatefulWidget {
  const UpdateShop({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateShop> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<UpdateShop> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const UpdateShopMobile(),
      desktop: (BuildContext context) => const UpdateShopWeb(),
    );
  }
}
