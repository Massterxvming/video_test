
import '../common/common.dart';
import '../route/route.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Test',
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      ),
      initialRoute: AppRoute.home,
      // routes: appRouteConfig,
      getPages: appGetPage,
      onReady: () {
        Get.changeThemeMode(ThemeMode.light);
      },
      defaultTransition: Transition.rightToLeft,
    );
  }
}
