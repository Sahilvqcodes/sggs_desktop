class LocalSggs {
  List<AngData>? data;

  LocalSggs({this.data});

  LocalSggs.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      data = <AngData>[];
      json["data"].forEach((v) {
        data!.add(new AngData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data["data"] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AngData {
  String? id;
  String? ang;
  String? name;
  String? english;
  String? serchEnglishData;
  String? serchPunjabiData;

  AngData(
      {this.id,
      this.ang,
      this.name,
      this.english,
      this.serchEnglishData,
      this.serchPunjabiData});

  AngData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ang = json['ang'];
    name = json['name'];
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ang'] = this.ang;
    data['name'] = this.name;
    data['english'] = this.english;
    return data;
  }
}
