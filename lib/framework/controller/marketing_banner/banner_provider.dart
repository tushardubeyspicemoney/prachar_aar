import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/marketing_banner/banner_controller.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';

final bannerProvider = ChangeNotifierProvider((ref) {
  final provider = getIt<BannerController>();
  return provider;
});
