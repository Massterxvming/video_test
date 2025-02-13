import '../common/common.dart';

class LikeButtons extends StatefulWidget {
  final double buttonSize;
  final IconData buttonIcon;
  final Color? activityColor;
  final Color? normalColor;
  final int likeCount;

  const LikeButtons({
    super.key,
    required this.buttonSize,
    required this.buttonIcon,
    this.activityColor,
    this.normalColor,
    required this.likeCount,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends AppPageBase<LikeButtons> {
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: widget.buttonSize,
      circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          widget.buttonIcon,
          color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
          size: widget.buttonSize,
        );
      },
      likeCount: widget.likeCount,
      // countBuilder: (int count, bool isLiked, String text) {
      //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
      //   Widget result;
      //   if (count == 0) {
      //     result = Text(
      //       "love",
      //       style: TextStyle(color: color),
      //     );
      //   } else
      //     result = Text(
      //       text,
      //       style: TextStyle(color: color),
      //     );
      //   return result;
      // },
    );
  }
}
