import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/auth/auth_provider.dart';
import 'package:my_flutter_module/ui/utils/widgets/common_device_configuration.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class AuthenticationWeb extends ConsumerStatefulWidget {
  const AuthenticationWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationWebState();
}

class _AuthenticationWebState extends ConsumerState<AuthenticationWeb> {
  @override
  Widget build(BuildContext context) {
    webDeviceConfiguration(context);
    final authProviderWatch = ref.watch(authProvider);
    return Scaffold(
      body:
          SafeArea(child: authProviderWatch.isError ? Center(child: Text(authProviderWatch.errorMsg)) : const Loader()),
    );
  }
}
