import 'package:flutter/foundation.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_data.dart';
import 'package:home_furniture_ui/core/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  String _selectedCategory = StringConst.categoryAll;
  String _searchQuery = '';

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  List<ProductModel> get filteredProducts {
    final products = AppData.productsByCategory(_selectedCategory);
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return products;
    return products.where((product) => product.name.toLowerCase().contains(query) || product.title.toLowerCase().contains(query)).toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
