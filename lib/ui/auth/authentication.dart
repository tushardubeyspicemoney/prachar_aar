import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/controller/auth/auth_provider.dart';
import 'package:my_flutter_module/ui/auth/mobile/authentication_mobile.dart';
import 'package:my_flutter_module/ui/auth/web/authentication_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Authentication extends ConsumerStatefulWidget {
  const Authentication({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProviderWatch = ref.watch(authProvider);
      await authProviderWatch.verifySession(ref, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const AuthenticationMobile();
      },
      desktop: (BuildContext context) {
        return const AuthenticationWeb();
      },
    );
  }
}
