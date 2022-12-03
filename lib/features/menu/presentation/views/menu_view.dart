import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/menu_view_cubit.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<MenuViewCubit, MenuViewState>(
      builder: (context, state) {
        if (state.status == MenuViewStatus.failure) {
          return Center(
            child: Text(
              'An error has occurred.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }

        final isLoading = state.status == MenuViewStatus.loading;

        return DefaultTabController(
          length: state.categories.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Explore menu'),
              backgroundColor: Colors.black87,
              bottom: isLoading
                  ? null
                  : TabBar(
                      isScrollable: true,
                      tabs: state.categories
                          .map((e) => Tab(child: Text(e.name)))
                          .toList(),
                    ),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: state.categories
                        .map((e) => Center(child: Text(e.name)))
                        .toList(),
                  ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
