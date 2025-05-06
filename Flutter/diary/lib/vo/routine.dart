
class Routine{

  int routineIdx = 0;
  int userIdx = 0;
  String routines = '';
  String color = '';

  Routine({
    this.routineIdx = 0,
    this.userIdx = 0,
    this.routines = '',
    this.color = '',
  });

  factory Routine.fromJson(Map<String, dynamic> map){
    return Routine(
      routineIdx: map['routine_idx']??0,
      userIdx: map['user_idx']??0,
      routines: map['routines']??'',
      color: map['color']??'',
    );
  }

}