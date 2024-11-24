class TodoList{

  final String id;
  final String title;
  final String subtitle;
  bool isComplete;

  TodoList({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isComplete = false,
  });

  factory TodoList.fromJson(Map<String, dynamic> json){
    return TodoList(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      isComplete: json['isComplete']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isComplete': isComplete,
    };
  }

}