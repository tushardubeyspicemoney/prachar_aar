// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:my_flutter_module/framework/controller/auth/auth_controller.dart' as _i21;
import 'package:my_flutter_module/framework/controller/dashboard/branding_controller.dart' as _i3;
import 'package:my_flutter_module/framework/controller/dashboard/dashboard_controller.dart' as _i4;
import 'package:my_flutter_module/framework/controller/dashboard/design_controller.dart' as _i25;
import 'package:my_flutter_module/framework/controller/dashboard/offer_controller.dart' as _i24;
import 'package:my_flutter_module/framework/controller/dashboard/shop_type_controller.dart' as _i19;
import 'package:my_flutter_module/framework/controller/home/home_controller.dart' as _i22;
import 'package:my_flutter_module/framework/controller/introduction/introduction_controller.dart' as _i18;
import 'package:my_flutter_module/framework/controller/marketing_banner/banner_controller.dart' as _i23;
import 'package:my_flutter_module/framework/dependency_injection/modules/dio_api_client.dart' as _i27;
import 'package:my_flutter_module/framework/dependency_injection/modules/dio_looger_module.dart' as _i26;
import 'package:my_flutter_module/framework/provider/network/dio/dio_client.dart' as _i8;
import 'package:my_flutter_module/framework/provider/network/dio/dio_logger.dart' as _i7;
import 'package:my_flutter_module/framework/repository/auth/contract/auth_repository.dart' as _i14;
import 'package:my_flutter_module/framework/repository/auth/repository/auth_api_repository.dart' as _i15;
import 'package:my_flutter_module/framework/repository/banner/contract/banner_repository.dart' as _i12;
import 'package:my_flutter_module/framework/repository/banner/repository/banner_api_repository.dart' as _i13;
import 'package:my_flutter_module/framework/repository/introduction/contract/introduction_repository.dart' as _i16;
import 'package:my_flutter_module/framework/repository/introduction/repository/introduction_api_repository.dart'
    as _i17;
import 'package:my_flutter_module/ui/routing/delegate.dart' as _i5;
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart' as _i20;
import 'package:my_flutter_module/ui/routing/parser.dart' as _i9;
import 'package:my_flutter_module/ui/routing/stack.dart' as _i6;

const String _debug = 'debug';
const String _production = 'production';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioLoggerModule = _$DioLoggerModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i3.BrandingController>(() => _i3.BrandingController());
    gh.factory<_i4.DashboardController>(() => _i4.DashboardController());
    gh.factoryParam<_i5.MainRouterDelegate, _i6.NavigationStack, dynamic>((
      stack,
      _,
    ) =>
        _i5.MainRouterDelegate(stack));
    gh.lazySingleton<_i7.DioLogger>(
      () => dioLoggerModule.getDioLogger(),
      registerFor: {
        _debug,
        _production,
      },
    );
    gh.lazySingleton<_i8.DioClient>(
      () => networkModule.getDebugDioClient(gh<_i7.DioLogger>()),
      registerFor: {_debug},
    );
    gh.factoryParam<_i9.MainRouterInformationParser, _i10.WidgetRef, _i11.BuildContext>((
      ref,
      context,
    ) =>
        _i9.MainRouterInformationParser(
          ref,
          context,
        ));
    gh.lazySingleton<_i12.BannerRepository>(
      () => _i13.BannerApiRepository(gh<_i8.DioClient>()),
      registerFor: {
        _debug,
        _production,
      },
    );
    gh.lazySingleton<_i14.AuthRepository>(
      () => _i15.CreditApiRepository(gh<_i8.DioClient>()),
      registerFor: {
        _debug,
        _production,
      },
    );
    gh.lazySingleton<_i16.IntroductionRepository>(
      () => _i17.IntroductionApiRepository(gh<_i8.DioClient>()),
      registerFor: {
        _debug,
        _production,
      },
    );
    gh.factory<_i18.IntroductionController>(() => _i18.IntroductionController(gh<_i16.IntroductionRepository>()));
    gh.factory<_i19.ShopTypeController>(() => _i19.ShopTypeController(gh<_i16.IntroductionRepository>()));
    gh.factoryParam<_i6.NavigationStack, List<_i20.NavigationStackItem>, dynamic>((
      items,
      _,
    ) =>
        _i6.NavigationStack(items));
    gh.lazySingleton<_i8.DioClient>(
      () => networkModule.getProductionDioClient(gh<_i7.DioLogger>()),
      registerFor: {_production},
    );
    gh.factory<_i21.AuthController>(() => _i21.AuthController(gh<_i14.AuthRepository>()));
    gh.factory<_i22.HomeController>(() => _i22.HomeController(gh<_i12.BannerRepository>()));
    gh.factory<_i23.BannerController>(() => _i23.BannerController(gh<_i12.BannerRepository>()));
    gh.factory<_i24.OfferController>(() => _i24.OfferController(gh<_i12.BannerRepository>()));
    gh.factory<_i25.DesignController>(() => _i25.DesignController(gh<_i12.BannerRepository>()));
    return this;
  }
}

class _$DioLoggerModule extends _i26.DioLoggerModule {}

class _$NetworkModule extends _i27.NetworkModule {}
