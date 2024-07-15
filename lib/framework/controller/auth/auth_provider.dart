import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/auth/auth_controller.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';

final authProvider = ChangeNotifierProvider((ref) {
  final authProvider = getIt<AuthController>();
  return authProvider;
});
