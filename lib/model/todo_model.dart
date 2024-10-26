
class TodoModel{
  String title;
  bool isCompleted;

  TodoModel({
     required this.title,
     required this.isCompleted,
  });

  // retrieve the data
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  // save data
  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
  };

}