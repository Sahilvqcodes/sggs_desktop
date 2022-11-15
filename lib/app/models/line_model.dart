class LineData {
  Data? data;
  int? count;

  LineData({this.data, this.count});

  LineData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class Data {
  int? id;
  String? ang;
  String? verse;

  Data({this.id, this.ang, this.verse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ang = json['ang'];
    verse = json['verse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ang'] = this.ang;
    data['verse'] = this.verse;
    return data;
  }
}
