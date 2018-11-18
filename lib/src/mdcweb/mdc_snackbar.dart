
import 'dart:html';

import 'package:mdcdavan/src/mdcweb/reg_elem.dart' as jsreg;
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

class MdcSnackbar {
  Element _element;
  static const MdcElemSpec _ELEM_SPEC =
    const MdcElemSpec(HtmlConsts.SPAN, MDC_CSS.SNACKBAR, [MDC_CSS.SNACKBAR__ALIGN_START]);

  static jsreg.MdcSnackbarJS _mdcSnackbarJS;
  static MdcSnackbar singletonElement;

  MdcSnackbar() {
    _element = _ELEM_SPEC.build();
    _element.append(new DivElement()..classes.add(MDC_CSS.SNACKBAR__TEXT));
    _element.append(new DivElement()..classes.add(MDC_CSS.SNACKBAR__ACTION_WRAPPER));

    ButtonElement b = new ButtonElement()
      ..classes.add(MDC_CSS.SNACKBAR__ACTION_BUTTON)
      ..setAttribute(HtmlConsts.TYPE, 'button');
    _element.append(b);
  }

  static void attach(Element e){
    if (singletonElement == null) {
      singletonElement = new MdcSnackbar();
      e.append(singletonElement._element);
      _mdcSnackbarJS = new jsreg.MdcSnackbarJS(singletonElement._element);
    }
  }

  static void show(String text) {
    _mdcSnackbarJS.showText(text);
  }
}
