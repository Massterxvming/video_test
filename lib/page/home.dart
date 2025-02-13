
import 'package:like_button/like_button.dart';
import 'package:video_test/widget/ilke_buttons.dart';
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
  TabItem _currentTab = TabItem.home;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            setState(() {
              _currentTab = TabItem.values[index];
            });
          },
          tabs: [
            Text(
              '首页',
              style: TextStyle(
                color: _currentTab == TabItem.home ? Colors.amberAccent : Colors.white,
                fontSize: 32,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              '词汇',
              style: TextStyle(
                color: _currentTab == TabItem.words ? Colors.amberAccent : Colors.white,
                fontSize: 32,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
          ),
        ],
      ),
      body: TabBarView(
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
                        LikeButtons(buttonSize: 100, buttonIcon: Icons.thumb_up, likeCount: 10),
                        SizedBox(width: 80),
                        LikeButtons(buttonSize: 100, buttonIcon: Icons.thumb_down, likeCount: 10),
                        SizedBox(width: 80),
                        LikeButtons(buttonSize: 100, buttonIcon: Icons.comment, likeCount: 10),
                        SizedBox(width: 80),
                        LikeButtons(buttonSize: 100, buttonIcon: Icons.share, likeCount: 10),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Container(color: Colors.yellow),
        ],
      ),
    );
  }
}
