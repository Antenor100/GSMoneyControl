import 'dart:convert';
import 'package:flutter/services.dart';

class JsonPropertiesHelper {
  Map? data;

  Future<JsonPropertiesHelper> create() async {
    data = await loadAllData();
    return this;
  }

  Future<Map> loadAllData() async {
    var jsonText = await rootBundle.loadString('assets/properties.json');
    return data = json.decode(jsonText);
  }

  String getTestCredentialGsheetApi () {
    return data!["gsheetApi"]["testCredential"];
  }

  String getTestSpreedsheetId () {
    return data!["gsheetApi"]["testSpreedsheetId"];
  }

  String getProdCredentialGsheetApi () {
    return data!["gsheetApi"]["prodCredential"];
  }

  String getProdSpreedsheetId () {
    return data!["gsheetApi"]["prodSpreedsheetId"];
  }
}