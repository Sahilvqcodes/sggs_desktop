class Gurugranth {
  List<Lines>? data;

  Gurugranth({this.data});

  Gurugranth.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Lines>[];
      json['data'].forEach((v) {
        data!.add(new Lines.fromJson(v));
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

class Lines {
  int? id;
  String? ang;
  String? name;
  String? english;
  String? hindi;
  String? arabic;
  String? gujarati;

  Lines(
      {this.id,
      this.ang,
      this.name,
      this.english,
      this.hindi,
      this.arabic,
      this.gujarati});

  Lines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ang = json['ang'];
    name = json['name'];
    english = json['english'];
    hindi = json['hindi'];
    arabic = json['arabic'];
    gujarati = json['gujarati'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ang'] = this.ang;
    data['name'] = this.name;
    data['english'] = this.english;
    data['hindi'] = this.hindi;
    data['arabic'] = this.arabic;
    data['gujarati'] = this.gujarati;
    return data;
  }
}
