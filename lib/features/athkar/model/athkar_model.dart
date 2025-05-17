class AthkarModel {
  String? text;
  int? count;

  AthkarModel(
      {required this.text,
        required this.count,
        });

  AthkarModel.fromJson(Map json){
    text = json["text"];
    count = json["count"];
  }
}
