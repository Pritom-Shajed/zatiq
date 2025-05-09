class ProductEntity {
  final int id;
  final String name;
  final String buyingPrice;
  final String sellingPrice;
  final int stock;
  final String img;
  final String brandName;
  final String categoryName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.stock,
    required this.img,
    required this.brandName,
    required this.categoryName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
