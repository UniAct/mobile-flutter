import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';

class TenantLogo extends StatelessWidget {
  const TenantLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  });

  static const String fallbackAsset = 'assets/images/logo.png';

  final double? width;
  final double? height;
  final BoxFit fit;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LocalStorage().getUniversityLogoUrl(),
      builder: (context, snapshot) {
        final logoUrl = snapshot.data?.trim();

        if (logoUrl == null || logoUrl.isEmpty) {
          return _fallback();
        }

        return Image.network(
          logoUrl,
          width: width,
          height: height,
          fit: fit,
          filterQuality: filterQuality,
          errorBuilder: (context, error, stackTrace) => _fallback(),
        );
      },
    );
  }

  Widget _fallback() {
    return Image.asset(
      fallbackAsset,
      width: width,
      height: height,
      fit: fit,
      filterQuality: filterQuality,
    );
  }
}
