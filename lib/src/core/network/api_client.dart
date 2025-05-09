import 'dart:convert';
import 'dart:io';

import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/configs/environment.dart';
import 'package:auth/src/core/network/enum/method.dart';
import 'package:auth/src/core/network/model/auth_store.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/logger/logger_helper.dart';
import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:auth/src/features/settings/data/repositories/hive_box.dart';
import 'package:auth/src/injector.dart';
import 'package:dio/dio.dart';

class ApiClient {
  AuthStore? authStore;
  final Dio dio = Dio();

  Future<void> init() async {
    authStore = Boxes.authStores.get(appName.toCamelWord);
    log.f('AuthStore: $authStore');
    log.f('AuthStore: ${authStore?.isAccessTokenValid}');
    if (authStore != null && !authStore!.isAccessTokenValid) {
      await signout();
      log.e('Automatically signed out due to invalid refresh token.');
    }
    _listenForAuthStore();
    _configureDio();
  }

  void _listenForAuthStore() {
    Boxes.authStores.watch(key: appName.toCamelWord).listen(
          (_) => authStore = Boxes.authStores.get(appName.toCamelWord),
        );
  }

  void _configureDio() {
    final baseUrl = sl<AppSettings>().isProduction ? Environment.prodBaseUrl : Environment.devBaseUrl;

    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          log.e('Dio Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  bool get isLoggedIn => authStore != null && authStore!.accessToken.isNotEmpty;

  Future<void> signout() async {
    try {
      await authStore?.deleteData();
      authStore = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> request(
    ApiClientMethod method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = false,
  }) async {
    try {
      final response = await dio.request(
        '/$endPoint',
        data: data,
        options: Options(
          method: method.value,
          headers: isAuthRequired
              ? {
                  'Authorization': 'Bearer ${authStore?.accessToken}',
                  'Content-Type': 'application/json',
                }
              : {'Content-Type': 'application/json'},
        ),
      );

      final responseData = jsonEncode(response.data);
      log.i('Response of $endPoint by $method: $responseData');
      return responseData;
    } on DioException catch (e) {
      log.e('Request failed: ${e.response?.data ?? e.message}');
      return Future.error(e.response?.data ?? e.message);
    } catch (e) {
      log.e('Request failed: $e');
      return Future.error(e);
    }
  }

  Future<Response> storeFile(
    List<String> paths, {
    bool isAuthRequired = true,
  }) async {
    final formData = FormData();

    for (final path in paths) {
      formData.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(path, filename: path.split('/').last),
      ));
    }

    final headers = <String, String>{
      if (isAuthRequired && authStore?.accessToken != null) 'Authorization': 'Bearer ${authStore!.accessToken}',
    };

    try {
      return await dio.post(
        '/file',
        data: formData,
        options: Options(headers: headers, contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      log.e('File upload failed: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
