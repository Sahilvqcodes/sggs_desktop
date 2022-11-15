import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gurugranth_app/app/models/local_sggs.dart';

class SggsHandler {
  static getAllShabad(BuildContext context, String ang) async {
    // await Future.delayed(Duration(seconds: 3));
    // print("_localSggs");
    var assetBundle = DefaultAssetBundle.of(context);

    var data = await assetBundle.loadString('assets/sggs.json');
    // print("data $data");
    var _localSggs = LocalSggs.fromJson(jsonDecode(data));
    // print("_localSggs ${_localSggs}");
    List<AngData>? _dataLines = _localSggs.data;
    List<AngData>? _dataLines1;
    List<AngData>? _dataLines2;

    _dataLines1 =
        _dataLines!.where((element) => element.ang == "$ang").toList();
    // _dataLines1.forEach(
    //   (element) {
    //     _dataLines1!.add(AngData(sl_no: "0"));
    //     print("_dataLines2![0].ang ${_dataLines1[0].sl_no}");
    //   },
    // );

    return _dataLines1;
  }

  static getLineNo(BuildContext context, String line_no) async {
    // await Future.delayed(Duration(seconds: 3));
    print("_localSggs");
    var assetBundle = DefaultAssetBundle.of(context);

    var data = await assetBundle.loadString('assets/sggs.json');
    // print("data $data");
    var _localSggs = LocalSggs.fromJson(jsonDecode(data));
    print("_localSggs ${_localSggs}");
    List<AngData>? _dataLines = _localSggs.data;
    List<AngData>? _dataLines1;
    List<AngData>? _dataLines2;
    // List<AngData>? _dataLines2;

    _dataLines1 =
        _dataLines!.where((element) => element.id == "$line_no").toList();
    print("_dataLines[0].ang ${_dataLines1[0].ang}");
    _dataLines2 = _dataLines
        .where((element) => element.ang == "${_dataLines1?[0].ang}")
        .toList();

    return _dataLines2;
  }

  static getEnglishSearch(BuildContext context, String textController) async {
    // await Future.delayed(Duration(seconds: 3));
    print("_localSggs");
    var assetBundle = DefaultAssetBundle.of(context);

    var data = await assetBundle.loadString('assets/sggs.json');
    // print("data $data");
    var _localSggs = LocalSggs.fromJson(jsonDecode(data));
    print("_localSggs ${_localSggs}");
    List<AngData>? _dataLines = _localSggs.data;
    List<AngData>? _dataLines1;
    List<AngData> _dataLines2 = [];
    // List<AngData>? _dataLines2;
    // print("textController $textController");
    _dataLines!.forEach((element) {
      var parts = element.english!.split(" ");
      // var parts = name.split(' ')
      // print("element.english ${element.english}");
      var initials = '';
      for (var i = 0; i < parts.length; i++) {
        if (parts[i].length > 0 && parts[i] != '') {
          initials += parts[i][0];
        }
      }
      _dataLines2.add(AngData(
          ang: element.ang,
          english: element.english,
          name: element.name,
          id: element.id,
          serchEnglishData: initials));
    });
    _dataLines1 = _dataLines2.where((element) {
      return element.serchEnglishData!
          .toLowerCase()
          .startsWith(textController.toLowerCase());
    }).toList();
    // print("_dataLines1 $_dataLines1");

    return _dataLines1;
  }

  static getPunjabiSearch(BuildContext context, String textController) async {
    // await Future.delayed(Duration(seconds: 3));
    // print("_localSggs");
    var assetBundle = DefaultAssetBundle.of(context);

    var data = await assetBundle.loadString('assets/sggs.json');
    // print("data $data");
    var _localSggs = LocalSggs.fromJson(jsonDecode(data));
    // print("_localSggs ${_localSggs}");
    List<AngData>? _dataLines = _localSggs.data;
    List<AngData>? _dataLines1;
    List<AngData> _dataLines2 = [];
    // List<AngData>? _dataLines2;
    // print("textController $textController");
    _dataLines!.forEach((element) {
      var parts = element.name!.split(" ");
      // var parts = name.split(' ')
      // print("element.english ${element.english}");
      var initials = '';
      for (var i = 0; i < parts.length; i++) {
        if (parts[i].length > 0 && parts[i] != '') {
          initials += parts[i][0];
        }
      }
      // print("initials $initials");
      _dataLines2.add(AngData(
          ang: element.ang,
          english: element.english,
          name: element.name,
          id: element.id,
          serchPunjabiData: initials));
      // print("_dataLines1 ${_dataLines2[0].name}");
    });
    _dataLines1 = _dataLines2
        .where(
            (element) => element.serchPunjabiData!.startsWith(textController))
        .toList();
    // print("_dataLines1 $_dataLines1");

    return _dataLines1;
  }

  static addMultiviewData(BuildContext context, String id) async {
    // await Future.delayed(Duration(seconds: 3));
    // print("_localSggs");
    print("id $id ");
    var assetBundle = DefaultAssetBundle.of(context);

    var data = await assetBundle.loadString('assets/sggs.json');
    // print("data $data");
    var _localSggs = LocalSggs.fromJson(jsonDecode(data));
    // print("_localSggs ${_localSggs}");
    List<AngData>? _dataLines = _localSggs.data;
    List<AngData>? _dataLines1;
    List<AngData>? _dataLines2;
    // List<AngData>? _dataLines2;
    // print("textController $textController");
    _dataLines1 =
        _dataLines!.where((element) => element.id == "${id}").toList();
    // print("_dataLines1 $_dataLines1");

    return _dataLines1;
  }
}
