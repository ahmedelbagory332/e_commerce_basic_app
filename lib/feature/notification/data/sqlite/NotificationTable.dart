class NotificationTable {
  int? _id;
  String? _title;
  String? _subtitle;
  String? _time;

  int? get id => _id;
  String? get title => _title;
  String? get subtitle => _subtitle;
  String? get time => _time;

  NotificationTable.init();

  NotificationTable({int? id, String? title, String? subtitle, String? time}) {
    _id = id;
    _title = title;
    _subtitle = subtitle;
    _time = time;
  } 
  NotificationTable.withOutId({String? title, String? subtitle, String? time}) {
    _title = title;
    _subtitle = subtitle;
    _time = time;
  }

  factory NotificationTable.fromMap(Map<String, dynamic> map) {
    return NotificationTable(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'title': _title,
    'subtitle': _subtitle,
    'time': _time
  };
}
