import '../common/common.dart';
import 'controller_base.dart';

class AppController extends ControllerBase{
  //保证实例不断变化
  static AppController get instance => Get.find<AppController>();
}