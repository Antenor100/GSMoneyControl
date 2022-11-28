import 'dart:io';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:gsheets/gsheets.dart';
import 'package:gsmoneycontrol/utils/helpers/get_json_properties.dart';
import 'package:test/test.dart';

class GsheetTest {
  static Future init() async {
    final jsonPropertiesHelper = await JsonPropertiesHelper().create();

    final spreadsheetId = jsonPropertiesHelper.getTestSpreedsheetId();
    final credentialGoogleSheetApi = jsonPropertiesHelper.getTestCredentialGsheetApi();

    final gsheets = GSheets(credentialGoogleSheetApi);

    final spreedsheet = await gsheets.spreadsheet(spreadsheetId);
    final Worksheet testSheet = await _getWorkSheet(spreedsheet, title: "tabelaTeste");

    //Test with data
    for (final row in await testSheet.values.allRows()) {
      print(row.toString());
    }
  }

  //Get a sheet in shpreadsheet ou create if not exists
  static Future<Worksheet> _getWorkSheet(Spreadsheet spreedsheet, {required String title}) async {
    try {
      return await spreedsheet.addWorksheet(title);
    } catch (e) {
      return spreedsheet.worksheetByTitle(title)!;
    }
  }
}

void main() {
  setUpAll(() {
    // Required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();

  test('Increment a test spreedsheet', () async {
    await GsheetTest.init();
  });
}