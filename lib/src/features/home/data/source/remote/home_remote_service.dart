import 'dart:convert';
import 'dart:io';

import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/network/endpoints/api_endpoints.dart';
import 'package:auth/src/core/network/enum/method.dart';
import 'package:auth/src/core/network/failure/failure.dart';
import 'package:auth/src/features/home/data/models/product_list_model.dart';
import 'package:auth/src/features/home/domain/entities/product/product_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class HomeRmoteService {
  Future<Either<Failure, ProductListEntity>> fetchProductList({required int pageNo});
}

class HomeRmoteServiceImpl extends HomeRmoteService {
  final ApiClient _apiClient;
  HomeRmoteServiceImpl(this._apiClient);

  @override
  Future<Either<Failure, ProductListEntity>> fetchProductList({required int pageNo}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        ApiEndpoints.productList(pageNo: pageNo),
      );

      final Map<String, dynamic> decoded = json.decode(response);
      final productList = ProductListModel.fromJson(decoded);
      return Right(productList);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      return Left(ServerFailure('API error: $message'));
    } on SocketException catch (e) {
      return Left(NetworkFailure('No internet connection. ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
