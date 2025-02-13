import '../common/common.dart';

class Portrait extends StatelessWidget {
  const Portrait({super.key, required this.size,required this.imgUrl,});
  final double size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = AssetImage(imgUrl);

    return  GestureDetector(
      onTap: (){
        Get.back();
      },
      child:
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imgUrl),
            fit: BoxFit.contain,
          ),
        ),
      )
    );
  }
}