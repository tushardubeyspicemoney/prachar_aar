import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_module/framework/dependency_injection/inject.dart';
import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';
import 'package:my_flutter_module/ui/routing/delegate.dart';
import 'package:my_flutter_module/ui/routing/parser.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  print("Build time ---> 7 Jun 2024 10:13");
  await HiveProvider.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureMainDependencies(environment: Env.prod);

  setPathUrlStrategy();

  dynamic appLanguage = await HiveProvider.get(LocalConst.language);
  if (appLanguage == null) {
    await HiveProvider.add(LocalConst.language, "en");
    appLanguage = "en";
  } else {
    await HiveProvider.add(LocalConst.language, appLanguage);
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      routerDelegate: getIt<MainRouterDelegate>(param1: ref.read(navigationStackProvider)),
      routeInformationParser: getIt<MainRouterInformationParser>(param1: ref, param2: context),
    );
  }
}
