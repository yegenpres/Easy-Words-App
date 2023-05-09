import 'package:sizer/sizer.dart';

class AppGeometry {
  dynamic Function(LocalizationGeometry<dynamic>) handler;

  AppGeometry(this.handler);

  double get borderRadius => handler(LocalizationGeometry<double>(
        cupertino: 12,
        material: 8,
      ));

  double get textSize => handler(LocalizationGeometry<double>(
        cupertino: 16,
        material: 10.sp,
      ));
}

class LocalizationGeometry<T> {
  final T cupertino;

  final T material;

  LocalizationGeometry({
    required this.cupertino,
    required this.material,
  });
}
