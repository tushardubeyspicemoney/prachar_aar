import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/home/home_controller.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';

final homeProvider = ChangeNotifierProvider((ref) {
  final homProvider = getIt<HomeController>();
  return homProvider;
});
