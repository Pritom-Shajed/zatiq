import 'package:auth/src/features/home/domain/entities/product/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.buyingPrice,
    required super.sellingPrice,
    required super.stock,
    required super.img,
    required super.brandName,
    required super.categoryName,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  // FROM JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      buyingPrice: json['buying_price'],
      sellingPrice: json['selling_price'],
      stock: json['stock'],
      img: json['img'],
      brandName: json['brand_name'],
      categoryName: json['category_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buying_price': buyingPrice,
      'selling_price': sellingPrice,
      'stock': stock,
      'img': img,
      'brand_name': brandName,
      'category_name': categoryName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // COPY WITH
  ProductModel copyWith({
    int? id,
    String? name,
    String? buyingPrice,
    String? sellingPrice,
    int? stock,
    String? img,
    String? brandName,
    String? categoryName,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stock: stock ?? this.stock,
      img: img ?? this.img,
      brandName: brandName ?? this.brandName,
      categoryName: categoryName ?? this.categoryName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
