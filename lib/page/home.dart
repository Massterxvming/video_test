import 'package:like_button/like_button.dart';
import 'package:video_test/widget/ilke_buttons.dart';
import 'package:video_test/widget/portrait.dart';
import 'package:video_test/widget/video_player.dart';

import '../common/common.dart';
import '../constant/config.dart';

enum TabItem { home, words }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends AppPageBase<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  Rx<TabItem> _currentTab = Rx(TabItem.home);
  final PageController _pageController = PageController();

  void addListener() {
    _tabController!.addListener(() {
      _currentTab.value = TabItem.values[_tabController!.index];
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    addListener();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          controller: _tabController,
          indicator: const BoxDecoration(),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          onTap: (index) {
            _currentTab.value = TabItem.values[index];
            // setState(() {
            //
            // });
          },
          tabs: [
            Obx(() {
              return Text(
                '首页',
                style: TextStyle(
                  color: _currentTab.value == TabItem.home ? Colors.amberAccent : Colors.white,
                  fontSize: 32,
                  decoration: TextDecoration.none,
                ),
              );
            }),
            Obx(() {
              return Text(
                '词汇',
                style: TextStyle(
                  color: _currentTab.value == TabItem.words ? Colors.amberAccent : Colors.white,
                  fontSize: 32,
                  decoration: TextDecoration.none,
                ),
              );
            }),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(()=>Portrait(size: 64, imgUrl: 'assets/image/avatar.jpg'));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32,
              foregroundImage: AssetImage('assets/image/avatar.jpg'),
            ),
          ),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          PageView.builder(
            itemCount: Config.videoUrls.length,
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  VideoPlay(videoUrl: Config.videoUrls[index]),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LikeButtons(buttonSize: 100, buttonIcon: Icons.thumb_up, likeCount: 11),
                        SizedBox(width: 80),
                        LikeButtons(
                          buttonSize: 100,
                          buttonIcon: Icons.thumb_down,
                        ),
                        SizedBox(width: 80),
                        LikeButtons(
                          buttonSize: 100,
                          buttonIcon: Icons.comment,
                        ),
                        SizedBox(width: 80),
                        LikeButtons(
                          buttonSize: 100,
                          buttonIcon: Icons.share,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          // Container(color: Colors.black, child: Icon(Icons.add),),
          Container(
            color: Colors.black,
            child: Image.asset('assets/image/cihui.png',fit:
              BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
