import '../common.dart';
import '../../controller/controller_base.dart';

abstract class AppStateBase<T extends StatefulWidget,C extends ControllerBase> extends State<T>  {
  StreamSubscription? themeSub;
  StreamSubscription? pageRebuildSub;
  C? controller;
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    themeSub = controller?.themeModeRx.listen((p0) {
      setState(() {});
    });
    pageRebuildSub = controller?.pageNeedRebuildRx.listen((p0) {
      setState(() { });
    });
  }

  @override
  void dispose() {
    super.dispose();
    themeSub?.cancel();
    pageRebuildSub?.cancel();
  }
}

abstract class AppPageBase<T extends StatefulWidget> extends AppStateBase<T, AppController>{
  @override
  AppController get controller => Get.find<AppController>();
}
