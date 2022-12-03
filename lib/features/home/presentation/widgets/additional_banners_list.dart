import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/slider_banner.dart';
import '../cubit/home_view_cubit.dart';

class AdditionalBannersList extends StatelessWidget {
  const AdditionalBannersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewCubit, HomeViewState>(
      builder: (context, state) {
        if (state.status == HomeViewStatus.failure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                'An error has occurred.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        }

        final isLoading = state.status == HomeViewStatus.loading ||
            state.status == HomeViewStatus.initial;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: isLoading ? 1 : state.additionalBanners.length,
            (context, index) {
              return _ListItem(
                banner: isLoading ? null : state.additionalBanners[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.banner,
  }) : super(key: key);

  final SliderBanner? banner;

  static const _loading = ColoredBox(
    color: Colors.black12,
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
        strokeWidth: 2,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 35 / 10,
          child: banner == null
              ? _loading
              : FadeInImage.memoryNetwork(
                  image: banner!.bannerImg,
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                ),
        ),
      ),
    );
  }
}
