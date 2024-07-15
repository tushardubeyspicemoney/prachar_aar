import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/dashboard/branding_controller.dart';
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_controller.dart';
import 'package:my_flutter_module/framework/controller/dashboard/design_controller.dart';
import 'package:my_flutter_module/framework/controller/dashboard/offer_controller.dart';
import 'package:my_flutter_module/framework/controller/dashboard/shop_type_controller.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';

final dashboardProvider = ChangeNotifierProvider((ref) {
  final dashProvider = getIt<DashboardController>();
  return dashProvider;
});

final brandingProvider = ChangeNotifierProvider((ref) {
  final branProvider = getIt<BrandingController>();
  return branProvider;
});

final designProvider = ChangeNotifierProvider((ref) {
  final desProvider = getIt<DesignController>();
  return desProvider;
});

final offerProvider = ChangeNotifierProvider((ref) {
  final offProvider = getIt<OfferController>();
  return offProvider;
});

final shopTypeProvider = ChangeNotifierProvider((ref) {
  final shTypeProvider = getIt<ShopTypeController>();
  return shTypeProvider;
});
