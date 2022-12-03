import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../menu/models/category.dart';
import '../../../menu/presentation/cubit/menu_view_cubit.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.titleLarge,
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
                    style: Theme.of(context).textTheme.bodySmall,
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
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          fit: BoxFit.fitHeight,
                          image: category!.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category!.name,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
