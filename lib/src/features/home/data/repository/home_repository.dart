import 'package:dartz/dartz.dart';
import 'package:zatiq/src/core/network/failure/failure.dart';
import 'package:zatiq/src/features/home/data/source/remote/home_remote_service.dart';
import 'package:zatiq/src/features/home/domain/entities/product/product_list_entity.dart';
import 'package:zatiq/src/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRmoteService _remoteService;
  HomeRepositoryImpl(this._remoteService);

  @override
  Future<Either<Failure, ProductListEntity>> fetchProductList({required int pageNo, String? searchQuery}) async {
    return await _remoteService.fetchProductList(pageNo: pageNo, searchQuery: searchQuery);
  }
}
