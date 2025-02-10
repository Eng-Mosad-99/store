import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/helper/app_assets.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder(
      {Key? key,
      required this.imageUrl,
      this.fit,
      this.width,
      this.height,
      this.shape})
      : super(key: key);
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width ?? 150.w,
        height: height ?? 150.h,
        fit: fit ?? BoxFit.fill,
        placeholder: (context, url) => SizedBox(
          height: height ?? 150.h,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 1,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppAssets.noImage,
          height: height ?? 150.h,
          width: width ?? 150.w,
        ),
        imageBuilder: (context, imageProvider) => Container(
          width: width ?? 200.0.w,
          height: height ?? 200.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
