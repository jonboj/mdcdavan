
import '../mda_base/mda_base_elem.dart';
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';


class MdcIconButton extends MdaBaseElem {
  static const MdcElemSpec ELEM_SPEC =
    const MdcElemSpec(HtmlConsts.DIV, MDC_CSS.ICON_BUTTON, [MDConsts.MATERIAL_ICONS]);

  MdcIconButton(final String iconStr) {
    element = ELEM_SPEC.build()..text = iconStr;
  }
}
