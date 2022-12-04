import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/navigation_cubit.dart';
import '../../../../core/models/category_model.dart';
import '../cubit/menu_view_cubit.dart';
import '../widgets/menu_tab_bar_view.dart';
import '../widgets/tab_item.dart';

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
                      indicatorColor: Colors.white,
                      tabs: state.categories
                          .map((e) => TabItem(category: e))
                          .toList(),
                    ),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _Body(categories: state.categories),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This code is used to change the Tab when the user taps a "Category item"
    // on the home page for the first time after the app launches.
    // Later taps are handled by the BlocListener below.
    final data = context.read<NavigationCubit>().state.data;
    if (data is! Category) return;
    final i = context.read<MenuViewCubit>().state.categories.indexOf(data);
    assert(i != -1);
    if (i != -1) DefaultTabController.of(context)!.animateTo(i);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) {
        return current.currentTab == 1 && current.data is Category;
      },
      listener: (context, state) {
        final tabIndex = context
            .read<MenuViewCubit>()
            .state
            .categories
            .indexOf(state.data! as Category);
        assert(tabIndex != -1);
        if (tabIndex != -1) {
          DefaultTabController.of(context)!.animateTo(tabIndex);
        }
      },
      child: TabBarView(
        children: widget.categories
            .map((category) => MenuTabBarView(category: category))
            .toList(),
      ),
    );
  }
}
