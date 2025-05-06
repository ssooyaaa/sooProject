

class Event{

  String text;
  String color;
  bool isChecked;

  Event({
    required this.text,
    required this.color,
    required this.isChecked
  });

  factory Event.fromJson(Map<String, dynamic> map){
    return Event(
      text: map['text'],
      color: map['color']??'',
      isChecked: map['is_checked']??false,
    );
  }

}