
class FileList{
  final id;
  late final fileName;
  final description;
  final downloadUrl;
  final ref;
  FileList({this.id, this.fileName, this.description, this.downloadUrl, this.ref});

  Map<String,dynamic> toMap(){
    return{
      'ref': ref,
      'id':id,
      'fileName':fileName,
      'description':description,
      'downloadUrl':downloadUrl
    };
  }
}