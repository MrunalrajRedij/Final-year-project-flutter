class Link{
  final id;
  final title;
  final link;
  Link({this.id, this.title, this.link});

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'link': link,
    };
  }
}