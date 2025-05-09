import 'package:auth/src/core/router/router.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:auth/src/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const name = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Trigger the fetch event using the globally provided bloc
    context.read<HomeBloc>().add(const HomeEvent.fetchProductList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goPushNamed(SettingsView.name);
        },
        child: const Icon(Icons.settings),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            // LOADED
            Loaded(
              :final productList,
            ) =>
              Center(
                child: Text('Loaded: ${productList.data.length}'),
              ),

            // LOADING
            Loading() => Center(child: AppLoaders.loaderWithText(context)),

            // ERROR
            Error(
              :final message,
            ) =>
              Center(
                child: Text('Error: $message'),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
