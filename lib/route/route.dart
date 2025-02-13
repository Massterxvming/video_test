
import '../common/common.dart';
import '../page/home.dart';

class AppRoute {
  AppRoute._();
  static String home = '/home';

}

List<GetPage> get appGetPage => [
      GetPage(name: AppRoute.home, page: () => const Home()),
    ];
