import 'package:auth/src/features/home/domain/entities/product/product_list_entity.dart';

import 'product_model.dart';

class ProductListModel extends ProductListEntity {
  const ProductListModel({
    required super.currentPage,
    required super.data,
    required super.firstPageUrl,
    required super.from,
    required super.lastPage,
    required super.lastPageUrl,
    required super.nextPageUrl,
    required super.path,
    required super.perPage,
    required super.prevPageUrl,
    required super.to,
    required super.total,
  });

  // FROM JSON
  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      currentPage: json['current_page'],
      data: List<ProductModel>.from(
        json['data'].map((x) => ProductModel.fromJson(x)),
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}
