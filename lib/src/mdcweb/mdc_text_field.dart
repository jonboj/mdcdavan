
import 'dart:html';

import 'package:mdcdavan/src/mdcweb/reg_elem.dart' as jsreg;

import '../mda_base/mda_base_elem.dart';
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

class MdcTextFieldInput extends MdaBaseElem {
  static const MdcElemSpec _ELEM_SPEC = const MdcElemSpec(HtmlConsts.INPUT, MDC_CSS.TEXT_FIELD__INPUT);
  MdcTextFieldInput(final String type) {
    element = _ELEM_SPEC.build();
    element.setAttribute(HtmlConsts.TYPE, type);
  }
}

class MdcTextField extends MdaNodeElemStatic implements MdcJsComp {

  jsreg.MdcTextFieldJS _mdcTextFieldJS;

  static const MdcElemSpec ELEM_SPEC = const MdcElemSpec(HtmlConsts.DIV, MDC_CSS.TEXT_FIELD);

  MdcTextField(List<MdaBaseElem> childs)
      : super(ELEM_SPEC.build(), childs);

  @override
  void mdcJsInitialSyncWithDOM() {
    _mdcTextFieldJS = new jsreg.MdcTextFieldJS(element);
  }

  String getValue() => _mdcTextFieldJS.value;
}
