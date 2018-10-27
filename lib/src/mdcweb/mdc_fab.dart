
import 'dart:html';

import 'mdc_css_classes.dart';
import 'html_const.dart';
import '../mda_base/mdc_elem_spec.dart';
import '../mda_base/mda_base_elem.dart';

class MdcFabIcon extends MdaBaseElem {

  static const MdcElemSpec ELEM_SPEC = const MdcElemSpec(HtmlConsts.SPAN, MDC_CSS.FAB__ICON, [MDConsts.MATERIAL_ICONS]);

  MdcFabIcon(final String iconStr) {
    element = ELEM_SPEC.build()..text = iconStr;
  }
}

class MdcFab extends MdaNodeElem {

  static final MdcElemSpec ELEM_SPEC = new MdcElemSpec(HtmlConsts.DIV, MDC_CSS.FAB);

  MdcFab(final String iconStr)
      : super(ELEM_SPEC.build(), [new MdcFabIcon(iconStr)]);
}
