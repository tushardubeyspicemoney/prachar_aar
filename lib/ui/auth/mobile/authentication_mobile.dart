import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/auth/auth_provider.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class AuthenticationMobile extends ConsumerStatefulWidget {
  const AuthenticationMobile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationMobileState();
}

class _AuthenticationMobileState extends ConsumerState<AuthenticationMobile> {
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfiguration(context);
    final authProviderWatch = ref.watch(authProvider);
    return Scaffold(
      body:
          SafeArea(child: authProviderWatch.isError ? Center(child: Text(authProviderWatch.errorMsg)) : const Loader()),
    );
  }
}
