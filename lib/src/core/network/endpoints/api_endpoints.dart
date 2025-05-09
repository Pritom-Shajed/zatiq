class ApiEndpoints {
  ApiEndpoints._();

  static String productList({int? pageNo, String? searchQuery}) =>
      'api/ProductList?page=${pageNo ?? ''}&search=${searchQuery ?? ''}';
}
