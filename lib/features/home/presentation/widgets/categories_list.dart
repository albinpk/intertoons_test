import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../navigation_cubit/navigation_cubit.dart';
import '../../../../core/models/category_model.dart';
import '../../../menu/presentation/cubit/menu_view_cubit.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Text(
            'Explore menu',
            style: textTheme.titleLarge,
          ),
        ),

        // Category list
        Expanded(
          child: BlocBuilder<MenuViewCubit, MenuViewState>(
            builder: (context, state) {
              if (state.status == MenuViewStatus.failure) {
                return Center(
                  child: Text(
                    'An error has occurred.',
                    style: textTheme.bodySmall,
                  ),
                );
              }

              final isLoading = state.status == MenuViewStatus.loading ||
                  state.status == MenuViewStatus.initial;

              return ListView.builder(
                itemCount: isLoading ? 3 : state.categories.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) {
                  return _ListItem(
                    category: isLoading ? null : state.categories[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: category == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const ColoredBox(
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                // Ink.image with FadeInImage not working.
                // Using Stack to place InkWell on top of the card.
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: category!.imageUrl,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category!.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    // Splash
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onTap(context),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    context.read<NavigationCubit>().changeTabWithData(1, data: category!);
  }
}
