@JS()
library reg_elem;

import 'dart:html';
import "package:js/js.dart";

@JS()
class MdcDialogJS {
  external MdcDialogJS(Element e);
  external void show();
}

@JS()
class MdcSnackbarJS {
  external MdcSnackbarJS(Element e);
  external void showText(String message);
}

@JS()
class MdcDrawerJS {
  external MdcDrawerJS(Element e);
  external set open(bool state);
}

@JS()
class MdcListJS {
  external MdcListJS(Element e);
}

@JS()
class MdcTextFieldJS {
  external MdcTextFieldJS(Element e);
  external String get value;
}

@JS()
external Element buildSlider(Element e, Function listenChange);
