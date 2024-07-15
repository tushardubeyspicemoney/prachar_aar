import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:my_flutter_module/ui/routing/navigation_stack_item.dart';

final navigationStackProvider = ChangeNotifierProvider((ref) => NavigationStack([
      const NavigationStackItem.appLoader(),
    ]));

//final navigationStackProvider = ChangeNotifierProvider((ref) => NavigationStack([]));

@injectable
class NavigationStack with ChangeNotifier {
  List<NavigationStackItem> _items;

  NavigationStack(@factoryParam List<NavigationStackItem> items) : _items = List.of(items);

  UnmodifiableListView<NavigationStackItem> get items => UnmodifiableListView(_items);

  set items(List<NavigationStackItem> newItems) {
    _items = List.from(newItems);
    notifyListeners();
  }

  void push(NavigationStackItem item) {
    _items.add(item);
    notifyListeners();
  }

  void pop() {
    if (_items.isNotEmpty) {
      _items.removeLast();
      notifyListeners();
    }
  }

  void pushRemove(NavigationStackItem item) {
    if (_items.isNotEmpty) {
      _items.removeLast();
      _items.add(item);
      notifyListeners();
    }
  }

  void pushAll(List<NavigationStackItem> newItems) {
    if (newItems.isNotEmpty) {
      _items.clear();
      for (NavigationStackItem newItem in newItems) {
        _items.add(newItem);
      }
    }
    notifyListeners();
  }

  void pushAndRemoveAll(NavigationStackItem item) {
    _items.clear();
    _items.add(item);
    notifyListeners();
  }
}
