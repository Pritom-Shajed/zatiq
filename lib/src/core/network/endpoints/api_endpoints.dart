class ApiEndpoints {
  ApiEndpoints._();

  static  String productList({int? pageNo}) => 'api/ProductList?page=$pageNo';
}