import 'package:flutter/foundation.dart';

class DetailProvider extends ChangeNotifier {
  int _selectedVariantIndex = 0;

  int get selectedVariantIndex => _selectedVariantIndex;

  void selectVariant(int index) {
    _selectedVariantIndex = index;
    notifyListeners();
  }
}
