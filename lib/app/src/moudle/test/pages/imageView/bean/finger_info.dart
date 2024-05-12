
enum FingerType{
  single,
  double,
  unKnow,
}
class FingerInfo{
   FingerType type;
   double dx;
   double dy;
   DateTime tapTime;
  FingerInfo({required this.type,required this.dx,required this.dy,required this.tapTime});
}