import 'package:flutter/foundation.dart' as foundation;

abstract class Build {
  static const bool isDebugMode = foundation.kDebugMode;

  static const bool isReleaseMode = foundation.kReleaseMode;

  static const bool isWeb = foundation.kIsWeb;

  static const bool isProfileMode = foundation.kProfileMode;
}
