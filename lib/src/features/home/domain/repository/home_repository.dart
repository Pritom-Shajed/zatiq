import 'package:auth/src/core/network/failure/failure.dart';
import 'package:auth/src/features/home/domain/entities/product/product_list_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, ProductListEntity>> fetchProductList({required int pageNo});
}
