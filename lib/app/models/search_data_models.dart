class SearchData {
  List<Data>? data;

  SearchData({this.data});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? ang;
  String? verse;
  String? english;

  Data({this.id, this.ang, this.verse, this.english});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ang = json['ang'];
    verse = json['verse'];
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ang'] = this.ang;
    data['verse'] = this.verse;
    data['english'] = this.english;
    return data;
  }
}
