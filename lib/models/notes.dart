class NotesModel {
  String? title, content;

  NotesModel({this.title, this.content});

  factory NotesModel.fromJson(Map<String, dynamic> json) =>
      NotesModel(title: json["title"] ?? "", content: json["content"] ?? "");
}
