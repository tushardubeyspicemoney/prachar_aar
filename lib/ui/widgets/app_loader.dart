import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/ui/widgets/loader.dart';

class AppLoader extends ConsumerStatefulWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends ConsumerState<AppLoader> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Loader()),
    );
  }
}
