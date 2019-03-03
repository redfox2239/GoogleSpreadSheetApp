function doGet(e) {
  var results = getSpreadSheetData()
  var payload = JSON.stringify(results)
  var output = ContentService.createTextOutput();
  output.setMimeType(ContentService.MimeType.JSON);
  output.setContent(payload);
  return output;
}

function getSpreadSheetData() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  Logger.log(sheet.getName())
  var range = sheet.getDataRange()
  var values = range.getValues()
  return values
}

