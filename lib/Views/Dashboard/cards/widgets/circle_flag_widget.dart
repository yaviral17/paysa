import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class CircleFlagWidget extends StatelessWidget {
  final String? countryCode;
  final double? radius;
  const CircleFlagWidget({
    super.key,
    this.countryCode = "in",
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkSVGImage(
      'https://hatscripts.github.io/circle-flags/flags/in.svg',
      placeholder: const Text(
        "Loading...",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      errorWidget: const Icon(Icons.error),
      width: 2 * radius!,
      height: 2 * radius!,
    );
  }
}
