import 'package:dartz/dartz.dart';
import 'package:zatiq/src/core/network/failure/failure.dart';
import 'package:zatiq/src/features/home/domain/entities/product/product_list_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, ProductListEntity>> fetchProductList({required int pageNo, String? searchQuery});
}
