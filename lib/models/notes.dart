class NotesModel {
  String? title, content;
  bool isShow;

  NotesModel({this.title, this.content, required this.isShow});

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      isShow: false);
}
