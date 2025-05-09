import 'package:auth/src/features/home/domain/entities/product/product_entity.dart';
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
    // Prevent duplicate fetch if already loading or no more data
    final currentState = state;
    if (currentState is Loaded && !currentState.hasMore) return;

    // Emit loading for the first page only
    if (event.page == 1) emit(const HomeState.loading());

    final result = await _fetchProductListUseCase(
      pageNo: event.page,
      searchQuery: event.searchQuery,
    );

    result.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (productList) {
        final products = productList.data;
        final totalCount = productList.total;

        final allProducts =
            currentState is Loaded && event.page > 1 ? [...currentState.products, ...products] : products;

        final hasMore = allProducts.length < totalCount;

        emit(HomeState.loaded(
          products: allProducts,
          currentPage: event.page,
          hasMore: hasMore,
          searchQuery: event.searchQuery,
        ));
      },
    );
  }
}
