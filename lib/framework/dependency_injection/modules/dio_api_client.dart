import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_client.dart';
import 'package:my_flutter_module/framework/provider/network/dio/dio_logger.dart';

///Demo
//baseUrl: "https://jsonplaceholder.typicode.com",

@module
abstract class NetworkModule {
  @LazySingleton(env: ['production'])
  DioClient getProductionDioClient(DioLogger dioLogger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://mtoolkit.spicemoney.com/mtoolkit",
      ),
    );
    //dio.interceptors.add(dioLogger);
    final client = DioClient(dio);
    return client;
  }

  @LazySingleton(env: ['debug'])
  DioClient getDebugDioClient(DioLogger dioLogger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://stg-services.spicemoney.com/mtoolkit",
      ),
    );
    dio.interceptors.add(dioLogger);
    final client = DioClient(dio);
    return client;
  }
}
