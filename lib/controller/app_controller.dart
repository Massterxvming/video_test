import '../common/common.dart';
import 'controller_base.dart';

class AppController extends ControllerBase{
  static AppController get instance => Get.find<AppController>();

  GetStorage box = GetStorage();
  saveData(String key, dynamic value) {
    box.write(key, value);
  }

  getData(String key) {
    return box.read(key);
  }
}