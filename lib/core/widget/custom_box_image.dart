import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomBoxImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final Color? color;
  final bool isNetwork;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final BoxFit? fit;
  const CustomBoxImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.bgColor,
    this.color,
    this.isNetwork = false,
    this.border,
    this.borderRadius = BorderRadius.zero,
    this.shape = BoxShape.rectangle,
    this.fit,
  });

  Widget imageAssetWidget() {
    if (shape == BoxShape.circle) {
      return ClipOval(
        child: Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        imageUrl,
        width: width,
        height: height,
      ),
    );
  }

  Widget imageNetworkWidget() {
    if (shape == BoxShape.circle) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          httpHeaders: const {'Connection': 'Keep-Alive'},
          color: color,
          fit: fit,
          errorWidget: (context, url, error) {
            return Container(
              width: width,
              height: width,
              color: Colors.grey.shade300,
            );
          },
          placeholder: (context, url) => Container(
            width: width,
            height: width,
            color: Colors.grey.shade300,
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        httpHeaders: const {'Connection': 'Keep-Alive'},
        color: color,
        fit: fit,
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: width,
            color: Colors.grey.shade300,
          );
        },
        placeholder: (context, url) => Container(
          width: width,
          height: width,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = imageAssetWidget();
    if (isNetwork) {
      imageWidget = imageNetworkWidget();
    }
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: bgColor,
        shape: shape,
      ),
      child: imageWidget,
    );
  }
}
