import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/framework/controller/auth/auth_provider.dart';
import 'package:my_flutter_module/ui/auth/authentication.dart';
import 'package:my_flutter_module/ui/create_offer_image/create_offer_image.dart';
import 'package:my_flutter_module/ui/create_offer_text/create_offer_text.dart';
import 'package:my_flutter_module/ui/dashboard/dashboard.dart';
import 'package:my_flutter_module/ui/edit_offer_image/edit_offer_image.dart';
import 'package:my_flutter_module/ui/edit_offer_text/edit_offer_text.dart';
import 'package:my_flutter_module/ui/faq/faq.dart';
import 'package:my_flutter_module/ui/get_started/get_started.dart';
import 'package:my_flutter_module/ui/home/home.dart';
import 'package:my_flutter_module/ui/poster_details/poster_details.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_keys.dart';
import 'package:my_flutter_module/ui/routing/params/product_params.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';
import 'package:my_flutter_module/ui/share_poster_details/share_poster_details.dart';
import 'package:my_flutter_module/ui/update_shop/update_shop.dart';
import 'package:my_flutter_module/ui/widgets/app_loader.dart';
import 'package:my_flutter_module/ui/widgets/first.dart';
import 'package:my_flutter_module/ui/widgets/not_found.dart';
import 'package:my_flutter_module/ui/widgets/second.dart';

@injectable
class MainRouterDelegate extends RouterDelegate<NavigationStack> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationStack stack;

  @override
  void dispose() {
    stack.removeListener(notifyListeners);
    super.dispose();
  }

  MainRouterDelegate(@factoryParam this.stack) : super() {
    stack.addListener(notifyListeners);
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Navigator(
        key: navigatorKey,
        pages: _pages(ref),

        /// callback when a page is popped.
        onPopPage: (route, result) {
          /// let the OS handle the back press if there was nothing to pop
          if (!route.didPop(result)) {
            return false;
          }

          /// if we are on root, let OS close app
          if (stack.items.length == 1) return false;

          /// if we are on root, let OS close app
          if (stack.items.isEmpty) return false;

          /// otherwise, pop the stack and consume the event
          stack.pop();
          return true;
        },
      );
    });
  }

  List<Page> _pages(WidgetRef ref) => stack.items
      .mapIndexed((e, i) => e.when(
            notFound: () => const MaterialPage(child: NotFound()),
            appLoader: () => const MaterialPage(child: AppLoader()),
            authentication: (ProductParams productParams) {
              ref.read(authProvider).updateProductParams(productParameters: productParams);
              return const MaterialPage(
                key: ValueKey(Keys.authentication),
                child: Authentication(),
              );
            },
            first: () {
              return const MaterialPage(
                key: ValueKey(Keys.first),
                child: First(),
              );
            },
            second: () {
              return const MaterialPage(
                key: ValueKey(Keys.second),
                child: Second(),
              );
            },
            getStarted: () {
              return const MaterialPage(
                key: ValueKey(Keys.getStarted),
                child: GetStarted(),
              );
            },
            dashboard: () {
              return const MaterialPage(
                key: ValueKey(Keys.dashboard),
                child: Dashboard(),
              );
            },
            home: () {
              return const MaterialPage(
                key: ValueKey(Keys.home),
                child: Home(),
              );
            },
            posterDetails: () {
              return const MaterialPage(
                key: ValueKey(Keys.posterDetails),
                child: PosterDetails(),
              );
            },
            offerText: () {
              return const MaterialPage(
                key: ValueKey(Keys.offerText),
                child: CreateOfferText(),
              );
            },
            offerImage: () {
              return const MaterialPage(
                key: ValueKey(Keys.offerImage),
                child: CreateOfferImage(),
              );
            },
            share: () {
              return const MaterialPage(
                key: ValueKey(Keys.share),
                child: SharePosterDetails(),
              );
            },
            editOfferImage: () {
              return const MaterialPage(
                key: ValueKey(Keys.editOfferImage),
                child: EditOfferImage(),
              );
            },
            editOfferText: () {
              return const MaterialPage(
                key: ValueKey(Keys.editOfferText),
                child: EditOfferText(),
              );
            },
            updateShop: () {
              return const MaterialPage(
                key: ValueKey(Keys.updateShop),
                child: UpdateShop(),
              );
            },
            faqText: () {
              return const MaterialPage(
                key: ValueKey(Keys.faq),
                child: Faq(),
              );
            },
          ))
      .toList();

  @override
  NavigationStack get currentConfiguration => stack;

  @override
  Future<void> setNewRoutePath(NavigationStack configuration) async {
    stack.items = configuration.items;
  }
}

extension _IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
