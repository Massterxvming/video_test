
import 'package:video_test/app/home_app.dart';

import 'common/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController(), permanent: true);
  await GetStorage.init();

  runApp(const HomeApp());
}
