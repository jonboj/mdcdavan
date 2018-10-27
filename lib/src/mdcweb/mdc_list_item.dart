
import 'dart:html';

import '../mda_base/mda_base_elem.dart';
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

class MdcListItem extends MdaBaseElem {

  static const MdcElemSpec ELEM_SPEC = const MdcElemSpec(HtmlConsts.A, MDC_CSS.LIST_ITEM);

  MdcListItem(String text, String iconType) {
    element = ELEM_SPEC.build();
    element.setAttribute('tabindex', '0');

    element.append(
        document.createElement(HtmlConsts.I)
          ..classes.addAll([MDConsts.MATERIAL_ICONS, MDC_CSS.LIST_ITEM__GRAPHIC])
          ..setAttribute('aria-hidden', 'true')
          ..text = iconType);

    element.append(
        new SpanElement()
          ..classes.add(MDC_CSS.LIST_ITEM__TEXT)
          ..text = text);
  }
}
