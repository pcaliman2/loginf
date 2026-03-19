import 'package:flutter/foundation.dart';

bool isDesktopFromContext(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);

  if (kIsWeb) {
    final adjustedWidth = mediaQuery.size.width * mediaQuery.devicePixelRatio;
    return adjustedWidth >= 1200;
  }

  return mediaQuery.size.width >= 1200;
}