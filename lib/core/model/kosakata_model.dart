class KosaKataModel {
  KosaKataModel({
    this.type,
    this.version,
    this.comment,
    this.name,
    this.database,
    this.data,
  });

  String? type;
  String? version;
  String? comment;
  String? name;
  String? database;
  List<Words>? data;

  factory KosaKataModel.fromJson(Map<String, dynamic> json) => KosaKataModel(
        type: json["type"],
        version: json["version"],
        comment: json["comment"],
        name: json["name"],
        database: json["database"],
        data: json["data"] == null
            ? []
            : List<Words>.from(json["data"]!.map((x) => Words.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "version": version,
        "comment": comment,
        "name": name,
        "database": database,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Words {
  Words({
    this.no,
    this.english,
    this.mandarin,
    this.pinying,
    this.translate,
  });

  String? no;
  String? english;
  String? mandarin;
  String? pinying;
  String? translate;

  factory Words.fromJson(Map<String, dynamic> json) => Words(
        no: json["No"],
        english: json["English"],
        mandarin: json["Mandarin"],
        pinying: json["Pinying"],
        translate: json["Translate"],
      );

  Map<String, dynamic> toJson() => {
        "No": no,
        "English": english,
        "Mandarin": mandarin,
        "Pinying": pinying,
        "Translate": translate,
      };
}
