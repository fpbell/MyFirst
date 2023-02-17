class Note {
  String? title, content;
  bool isShow;
  final dynamic id;

  Note({this.id = 0, this.title = '', this.content = '', required this.isShow});

  //factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
  //  title: json["title"] ?? "",
  // content: json["content"] ?? "",
  //  isShow: false);

  //Map<String, dynamic> toJson() {
  //  final Map<String, dynamic> data = <String, dynamic>{};
  //  data['title'] = title;
  //  data['content'] = content;
  //return data;
  //}

  Note.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            content: json['content'],
            isShow: false);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};
}
