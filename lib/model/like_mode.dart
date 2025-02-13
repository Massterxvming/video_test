class LikeMode {
  int id;
  int num;
  LikeModeType type;

  LikeMode({required this.id, required this.num,required this.type});

  factory LikeMode.fromTemp()=>LikeMode(id: 0, num: 11, type: LikeModeType.like);


}
enum LikeModeType {
  like,
  dislike,
}