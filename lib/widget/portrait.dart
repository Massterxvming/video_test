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
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.07),
          radius: size,
          foregroundImage:imageProvider,
        ),
      ),
    );
  }
}