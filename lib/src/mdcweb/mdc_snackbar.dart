
import 'dart:html';

import 'package:mdcdavan/src/mdcweb/reg_elem.dart' as jsreg;
import '../mda_base/mdc_elem_spec.dart';

import 'html_const.dart';
import 'mdc_css_classes.dart';

class MdcSnackbar {
  Element _element;
  static const MdcElemSpec _ELEM_SPEC =
    const MdcElemSpec(HtmlConsts.SPAN, MDC_CSS.SNACKBAR);

  static jsreg.MdcSnackbarJS _mdcSnackbarJS;
  static MdcSnackbar singletonElement;

  MdcSnackbar() {
    DivElement snackBarSurface = new DivElement()..classes.add(MDC_CSS.SNACKBAR__SURFACE);
    DivElement snackBarLabel = new DivElement()
      ..classes.add(MDC_CSS.SNACKBAR__LABEL)
      ..setAttribute("role", "status")
      ..setAttribute("aria-live", "polite");
    snackBarSurface.append(snackBarLabel);

    _element = _ELEM_SPEC.build();
    _element.append(snackBarSurface);
  }

  static void attach(Element e){
    if (singletonElement == null) {
      singletonElement = new MdcSnackbar();
      e.append(singletonElement._element);
      _mdcSnackbarJS = new jsreg.MdcSnackbarJS(singletonElement._element);
    }
  }

  static void show(String text) {
    _mdcSnackbarJS.labelText = text;
    _mdcSnackbarJS.open();
  }
}
