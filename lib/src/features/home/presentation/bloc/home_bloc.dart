import 'package:auth/src/core/network/failure/failure.dart';
import 'package:auth/src/features/home/domain/entities/product/product_list_entity.dart';
import 'package:auth/src/features/home/domain/usecase/fetch_product_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchProductListUseCase _fetchProductListUseCase;

  HomeBloc(this._fetchProductListUseCase) : super(const HomeState.initial()) {
    on<FetchProductList>(_onFetchProductList);
  }

  Future<void> _onFetchProductList(
    FetchProductList event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    final result = await _fetchProductListUseCase(pageNo: event.page);

    result.fold(
      (Failure failure) => emit(HomeState.error(failure.message)),
      (ProductListEntity productList) => emit(HomeState.loaded(productList)),
    );
  }
}
