class MultiviewData {
  List<AddedMultiview>? data;

  MultiviewData({this.data});

  MultiviewData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddedMultiview>[];
      json['data'].forEach((v) {
        data!.add(new AddedMultiview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddedMultiview {
  int? id;
  String? ang;
  String? verseId;
  String? shabadId;
  String? verse;
  String? raag;
  Null? createdAt;
  Null? updatedAt;

  AddedMultiview(
      {this.id,
      this.ang,
      this.verseId,
      this.shabadId,
      this.verse,
      this.raag,
      this.createdAt,
      this.updatedAt});

  AddedMultiview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ang = json['ang'];
    verseId = json['verseId'];
    shabadId = json['shabadId'];
    verse = json['verse'];
    raag = json['raag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ang'] = this.ang;
    data['verseId'] = this.verseId;
    data['shabadId'] = this.shabadId;
    data['verse'] = this.verse;
    data['raag'] = this.raag;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
