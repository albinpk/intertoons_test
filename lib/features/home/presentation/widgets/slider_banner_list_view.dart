import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/slider_banner.dart';
import '../cubit/home_view_cubit.dart';

class SliderBannerListView extends StatelessWidget {
  const SliderBannerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewCubit, HomeViewState>(
      builder: (context, state) {
        if (state.status == HomeViewStatus.failure) {
          return Center(
            child: Text(
              'An error has occurred.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }

        final isLoading = state.status == HomeViewStatus.loading ||
            state.status == HomeViewStatus.initial;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: isLoading
              ? const BouncingScrollPhysics()
              : const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: isLoading ? 2 : state.sliderBanners.length,
          itemBuilder: (context, index) {
            return _SliderItem(
              banner: isLoading ? null : state.sliderBanners[index],
            );
          },
        );
      },
    );
  }
}

class _SliderItem extends StatelessWidget {
  const _SliderItem({
    Key? key,
    this.banner,
  }) : super(key: key);

  /// The slider banner object.
  ///
  /// If it is null then shows a loading widget.
  final SliderBanner? banner;

  static const _loadingWidget = ColoredBox(
    color: Colors.black12,
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.grey,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: banner == null
              ? _loadingWidget
              : FadeInImage.memoryNetwork(
                  image: banner!.bannerImg,
                  placeholder: kTransparentImage,
                ),
        ),
      ),
    );
  }
}
