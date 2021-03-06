@JS()
library reg_elem;

import 'dart:html';
import "package:js/js.dart";

@JS()
class MdcDialogJS {
  external MdcDialogJS(Element e);
  external void open();
  external void close();
}

@JS()
class MdcSnackbarJS {
  external MdcSnackbarJS(Element e);
  external void open();
  external set labelText(String text);
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
class MdcSliderJS {
  external MdcSliderJS(Element e);
  external int get value;
  external void layout();//Re-computes layout
}
