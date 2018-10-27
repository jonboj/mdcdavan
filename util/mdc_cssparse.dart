
import 'dart:io';

//Util for generation of constants in class MDC_CSS, build and run as Dart console program.

//Version 0.40.0
//'https://unpkg.com/material-components-web@0.40.0/dist/material-components-web.min.css';
const String MDC_CSS_FILE = 'material-components-web.min.css';

main(List<String> arguments) async {
  String fileContent = await new File(MDC_CSS_FILE).readAsString();

  print('Size of file : ' + fileContent.length.toString());

  RegExp exp = new RegExp(r"\.mdc(-\w+)+(__\w+)?(-+\w+)*{");
  List<String> matches = exp.allMatches(fileContent)
      .map((Match m) => m.group(0))
      .toSet().toList();
  matches.sort((String s1, String s2 ) => s1.compareTo(s2));

  List<String> listConstStr = matches.map(_cutRaw).toList();

  listConstStr.forEach((String s){ print('  static const String ' + _rawToConsStr(s) + ' = \'mdc-' + s + '\';');});
}

String _cutRaw(final String s) {
  final int lStr = s.length;
  return s.substring(5, lStr - 1);//Remove .mdc and end {
}

String _rawToConsStr(final String s) =>
    s.toUpperCase().replaceAll('-', '_');
