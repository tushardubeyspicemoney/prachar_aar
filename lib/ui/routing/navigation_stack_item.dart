import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_module/ui/routing/params/product_params.dart';

part 'navigation_stack_item.freezed.dart';

@freezed
class NavigationStackItem with _$NavigationStackItem {
  //const factory NavigationStackItem.advanceCredit() = NavigationStackItemAdvanceCredit;
  const factory NavigationStackItem.appLoader() = NavigationStackAppLoader;

  const factory NavigationStackItem.notFound() = NavigationStackItemNotFound;

  const factory NavigationStackItem.first() = NavigationStackFirst;

  const factory NavigationStackItem.second() = NavigationStackSecond;

  const factory NavigationStackItem.getStarted() = NavigationStackItemGetStarted;

  const factory NavigationStackItem.dashboard() = NavigationStackItemDashboard;

  const factory NavigationStackItem.home() = NavigationStackItemHome;

  const factory NavigationStackItem.posterDetails() = NavigationStackItemPosterDetails;

  const factory NavigationStackItem.offerText() = NavigationStackItemOfferText;

  const factory NavigationStackItem.offerImage() = NavigationStackItemOfferImage;

  const factory NavigationStackItem.share() = NavigationStackItemShare;

  const factory NavigationStackItem.editOfferText() = NavigationStackItemeditOfferText;

  const factory NavigationStackItem.editOfferImage() = NavigationStackItemeditOfferImage;

  const factory NavigationStackItem.authentication({required ProductParams productParams}) =
      NavigationStackItemAuthentication;

  const factory NavigationStackItem.updateShop() = NavigationStackItemUpdateShop;

  const factory NavigationStackItem.faqText() = NavigationStackItemFaqText;
}
