import 'package:auth/src/core/network/failure/failure.dart';
import 'package:auth/src/features/home/domain/entities/product/product_list_entity.dart';
import 'package:auth/src/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class FetchProductListUseCase {
  final HomeRepository _repository;

  FetchProductListUseCase(this._repository);

  Future<Either<Failure, ProductListEntity>> call({required int pageNo, String? searchQuery}) async {
    return await _repository.fetchProductList(pageNo: pageNo, searchQuery: searchQuery);
  }
}
