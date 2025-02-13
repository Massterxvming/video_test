import '../common/common.dart';

class ControllerBase extends GetxController {
  /// 需要重建页面
  Rx<bool> pageNeedRebuildRx = Rx(false);

  /// 当前主题
  Rx<ThemeMode> themeModeRx = Rx(ThemeMode.system);
}
