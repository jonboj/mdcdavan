
import '../mda_base/mdc_elem_spec.dart';
import '../mda_base/mda_base_elem.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

class MdcFloatingLabel extends MdaBaseElem {
  static const MdcElemSpec ELEM_SPEC = const MdcElemSpec(HtmlConsts.LABEL, MDC_CSS.FLOATING_LABEL);
  MdcFloatingLabel(String text) {
    element = ELEM_SPEC.build()..text = text;
  }
}

