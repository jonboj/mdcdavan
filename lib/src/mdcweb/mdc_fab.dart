
import '../mda_base/mdc_elem_spec.dart';
import '../mda_base/mda_base_elem.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

class MdcFabIcon extends MdaBaseElem {

  static const MdcElemSpec _ELEM_SPEC = const MdcElemSpec(HtmlConsts.SPAN, MDC_CSS.FAB__ICON, [MDConsts.MATERIAL_ICONS]);

  MdcFabIcon(final String iconStr) {
    element = _ELEM_SPEC.build()..text = iconStr;
  }
}

class MdcFab extends MdaNodeElemStatic {

  static const MdcElemSpec _ELEM_SPEC = const MdcElemSpec(HtmlConsts.DIV, MDC_CSS.FAB);

  MdcFab(final String iconStr)
      : super(_ELEM_SPEC.build(), [new MdcFabIcon(iconStr)]){
  }
}
