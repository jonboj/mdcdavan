
import 'dart:html';

import '../mda_base/mdc_elem_spec.dart';
import '../mda_base/mda_base_elem.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';
import 'mdc_icon_button.dart';

class MdcTopAppBarData {
  final String toolBarTitle;
  final String userField;
  final List<String> icons;

  const MdcTopAppBarData(this.toolBarTitle, this.userField, this.icons);
}

class MdcTopAppBarDataDemo extends MdcTopAppBarData {
  const MdcTopAppBarDataDemo()
  : super('ToolBar title', 'User_Field', const ['print', 'bookmark']);
}

class MdcTopAppBar extends MdaBaseElem {

  static const MdcElemSpec _ELEM_SPEC =
    const MdcElemSpec(HtmlConsts.HEADER, MDC_CSS.TOP_APP_BAR, [MDC_CSS.TOP_APP_BAR__FIXED]);

  MdcIconButton _menuElem;

  MdcTopAppBar(MdcTopAppBarData appData) {
    element = _ELEM_SPEC.build();
    _buildStructure(appData);
  }

  Stream<MouseEvent> menuClick() =>  _menuElem.element.onClick;

  void _buildStructure(final MdcTopAppBarData appData) {
    DivElement topRow = new DivElement();
    topRow.classes.add(MDC_CSS.TOP_APP_BAR__ROW);

    //Menu icon and title.
    Element startSection = Element.section()
      ..classes.addAll([MDC_CSS.TOP_APP_BAR__SECTION, MDC_CSS.TOP_APP_BAR__SECTION__ALIGN_START]);

    _menuElem = new MdcIconButton('menu');
    _menuElem.element.classes.add(MDC_CSS.TOP_APP_BAR__NAVIGATION_ICON);
    startSection.append(_menuElem.element);

    SpanElement titleE = new SpanElement()
      ..classes.add(MDC_CSS.TOP_APP_BAR__TITLE)
      ..text = appData.toolBarTitle;

    startSection.append(titleE);

    //Toolbar
    Element endSection = Element.section()
      ..classes.addAll([MDC_CSS.TOP_APP_BAR__SECTION, MDC_CSS.TOP_APP_BAR__SECTION__ALIGN_END])
      ..setAttribute('role', 'toolbar');

    SpanElement accountField = new SpanElement()
      ..classes.add(MDC_CSS.TOP_APP_BAR__TITLE)
      ..text = appData.userField;
    endSection.append(accountField);

    topRow.append(startSection);
    topRow.append(endSection);

    element.append(topRow);
  }

}
