import 'package:flutter/foundation.dart';

import '../common.dart';

extension ObjectExtension on Object? {
  get p {
    if (kDebugMode) logger.i(this);
    return this;
  }
  get e {
    if (kDebugMode) logger.e(this);
    return this;
  }
}