import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_logger.dart';

@module
abstract class DioLoggerModule {
  @LazySingleton(env: ['debug', 'production'])
  DioLogger getDioLogger() {
    final dioLogger = DioLogger();
    return dioLogger;
  }
}
