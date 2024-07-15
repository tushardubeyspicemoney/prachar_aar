import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_keys.dart';
import 'package:my_flutter_module/ui/routing/params/product_params.dart';
import 'package:my_flutter_module/ui/routing/stack.dart';

@injectable
class MainRouterInformationParser extends RouteInformationParser<NavigationStack> {
  WidgetRef ref;
  BuildContext context;

  MainRouterInformationParser(@factoryParam this.ref, @factoryParam this.context);

  ///Parse Screen from URL
  @override
  Future<NavigationStack> parseRouteInformation(RouteInformation routeInformation) async {
    print("........URL......${routeInformation.location}");

    Uri uri = Uri.parse(routeInformation.location ?? "");
    // Uri uri = Uri.parse("https://stg-services.spicemoney.com/marketing-tool/auth?clientId=180596&token=488238630BCCF04AABFE135F21A875968935BA99D4B92C348AF745AB51439224&aggId=109&udf1=APP");

    final queryParams = uri.queryParameters;
    print("........queryParams....$queryParams");
    final items = <NavigationStackItem>[];

    for (var i = 0; i < uri.pathSegments.length; i = i + 1) {
      final key = uri.pathSegments[i];

      switch (key) {
        case Keys.authentication:
          if (queryParams.isNotEmpty) {
            String encodedStr = json.encode(queryParams);
            ProductParams productParams = productParamsFromJson(encodedStr);
            if (productParams.clientId.isNotEmpty &&
                productParams.token.isNotEmpty &&
                productParams.aggId.isNotEmpty &&
                productParams.udf1.isNotEmpty) {
              items.add(NavigationStackItem.authentication(productParams: productParams));
            } else {
              items.add(const NavigationStackItem.notFound());
            }
          } else {
            items.add(const NavigationStackItem.notFound());
          }
          break;

        case Keys.first:
          items.add(const NavigationStackItem.first());
          break;

        case Keys.second:
          items.add(const NavigationStackItem.second());
          break;

        case Keys.getStarted:
          items.add(const NavigationStackItem.getStarted());
          break;

        case Keys.dashboard:
          items.add(const NavigationStackItem.dashboard());
          break;

        case Keys.home:
          items.add(const NavigationStackItem.home());
          break;

        case Keys.posterDetails:
          items.add(const NavigationStackItem.posterDetails());
          break;

        case Keys.offerImage:
          items.add(const NavigationStackItem.offerImage());
          break;

        case Keys.offerText:
          items.add(const NavigationStackItem.offerText());
          break;

        case Keys.share:
          items.add(const NavigationStackItem.share());
          break;

        case Keys.editOfferText:
          items.add(const NavigationStackItem.editOfferText());
          break;

        case Keys.editOfferImage:
          items.add(const NavigationStackItem.editOfferImage());
          break;

        case Keys.updateShop:
          items.add(const NavigationStackItem.updateShop());
          break;

        case Keys.faq:
          items.add(const NavigationStackItem.faqText());
          break;

        default:
          items.add(const NavigationStackItem.appLoader());
      }
    } // for

    /*if (items.isEmpty) {
      const fallback = NavigationStackItem.getStarted();
      //const fallback = NavigationStackItem.share();
      //const fallback = NavigationStackItem.home();
      //const fallback = NavigationStackItem.offerText();
      if (items.isNotEmpty && items.first is NavigationStackItemNotFound) {
        items[0] = fallback;
      } else {
        items.insert(0, fallback);
      }
    }*/
    return NavigationStack(items);
  }

  ///THIS IS IMPORTANT: Here we restore the web history
  @override
  RouteInformation? restoreRouteInformation(NavigationStack configuration) {
    final location = configuration.items.fold<String>("", (previousValue, element) {
      return previousValue +
          element.when(
            authentication: (ProductParams productParams) => "",
            notFound: () => "",
            appLoader: () => "",
            first: () => "/${Keys.first}",
            second: () => "/${Keys.second}",
            getStarted: () => "/${Keys.getStarted}",
            dashboard: () => "/${Keys.dashboard}",
            home: () => "/${Keys.home}",
            posterDetails: () => "/${Keys.posterDetails}",
            offerText: () => "/${Keys.offerText}",
            offerImage: () => "/${Keys.offerImage}",
            share: () => "/${Keys.share}",
            editOfferImage: () => "/${Keys.editOfferImage}",
            editOfferText: () => "/${Keys.editOfferText}",
            updateShop: () => "/${Keys.updateShop}",
            faqText: () => "/${Keys.faq}",
          );
    });
    return RouteInformation(location: location);
  }
}
