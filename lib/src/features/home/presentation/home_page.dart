import 'package:auth/src/core/router/router.dart';
import 'package:auth/src/core/shared/button/basic_app_button.dart';
import 'package:auth/src/core/shared/page_padding/page_padding.dart';
import 'package:auth/src/core/shared/text_field/basic_text_field.dart';
import 'package:auth/src/core/utils/colors/app_colors.dart';
import 'package:auth/src/core/utils/debouncer/debouncer.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/core/utils/responsive/responsive_utils.dart';
import 'package:auth/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:auth/src/features/home/presentation/components/product_card.dart';
import 'package:auth/src/features/settings/presentation/view/settings_view.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:solar_icon_pack/solar_linear_icons.dart';

class HomePage extends StatefulWidget {
  static const name = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialApiCall();
    });
  }

  initialApiCall() async {
    context.read<HomeBloc>().add(const HomeEvent.fetchProductList());
  }

  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  void _onScroll() {
    final bloc = context.read<HomeBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (state is Loaded && state.hasMore) {
        bloc.add(
          HomeEvent.fetchProductList(
            page: state.currentPage + 1,
            searchQuery: state.searchQuery,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.product),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goPushNamed(SettingsView.name);
        },
        child: const Icon(Icons.settings),
      ),
      body: PagePadding(
        child: Column(
          spacing: 12,
          children: [
            // SEARCH BAR & REFRESH BUTTON
            Row(
              children: [
                Expanded(
                  child: BasicTextField(
                    hintText: t.productName,
                    controller: _searchController,
                    prefixIcon: const Icon(SolarLinearIcons.magnifer),
                    validator: FormBuilderValidators.required(),
                    onChanged: (value) {
                      _debouncer(() {
                        context.read<HomeBloc>().add(FetchProductList(
                              searchQuery: value,
                            ));
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                    context.read<HomeBloc>().add(const FetchProductList());
                  },
                  icon: const Icon(SolarLinearIcons.refresh),
                ),
              ],
            ),

            // BODY
            Expanded(
              child: RefreshIndicator(
                color: AppColors.white,
                onRefresh: () => initialApiCall(),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return switch (state) {
                      // LOADED
                      Loaded(
                        :final products,
                      ) =>
                        ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (_, __) => SizedBox(height: ResponsiveUtil.scaleSize(context, 12)),
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            final product = products[index];
                            return ProductCard(product: product);
                          },
                        ),

                      // LOADING
                      Loading() => Center(child: AppLoaders.loaderWithText(context)),

                      // ERROR
                      Error(
                        :final message,
                      ) =>
                        SingleChildScrollView(
                            child: Column(
                          spacing: 12,
                          children: [
                            Text('Error: $message'),
                            BasicAppButton(
                              onTap: () => initialApiCall(),
                              title: 'Reload',
                            )
                          ],
                        )),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
