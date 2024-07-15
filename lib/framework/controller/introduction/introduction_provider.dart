import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/introduction/introduction_controller.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';

final introductionProvider = ChangeNotifierProvider((ref) {
  final provider = getIt<IntroductionController>();
  return provider;
});
