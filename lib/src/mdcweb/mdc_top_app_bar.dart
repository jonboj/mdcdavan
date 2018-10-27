
import 'dart:html';

import '../mda_base/mdc_elem_spec.dart';
import '../mda_base/mda_base_elem.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';

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

class MdcTopAppBar extends MdaBaseElem implements MdaStreamElem<MouseEvent> {

  static const String STREAM_ID = 'MDC_TOP_APP_BAR';
  static const MdcElemSpec ELEM_SPEC =
    const MdcElemSpec(HtmlConsts.HEADER, MDC_CSS.TOP_APP_BAR, [MDC_CSS.TOP_APP_BAR__FIXED]);

  AnchorElement _menuElem;

  MdcTopAppBar(MdcTopAppBarData appData) {
    element = ELEM_SPEC.build();
    _buildStructure(appData);
  }

  @override
  StreamRef<MouseEvent> getStreamRef() =>
      new StreamRef(STREAM_ID, _menuElem.onClick);

  void _buildStructure(final MdcTopAppBarData appData) {
    DivElement topRow = new DivElement();
    topRow.classes.add(MDC_CSS.TOP_APP_BAR__ROW);

    //Menu icon and title.
    Element startSection = Element.section()
      ..classes.addAll([MDC_CSS.TOP_APP_BAR__SECTION, MDC_CSS.TOP_APP_BAR__SECTION__ALIGN_START]);

    _menuElem = new AnchorElement(href: '#')
      ..classes.addAll([MDConsts.MATERIAL_ICONS, MDC_CSS.TOP_APP_BAR__NAVIGATION_ICON])
      ..text = 'menu';
    startSection.append(_menuElem);

    SpanElement titleE = new SpanElement()
      ..classes.add(MDC_CSS.TOP_APP_BAR__TITLE)
      ..text = appData.toolBarTitle;

    startSection.append(_menuElem);
    startSection.append(titleE);

    //Toolbar
    Element endSection = Element.section()
      ..classes.addAll([MDC_CSS.TOP_APP_BAR__SECTION, MDC_CSS.TOP_APP_BAR__SECTION__ALIGN_END])
      ..setAttribute('role', 'toolbar');

    SpanElement accountField = new SpanElement()
      ..classes.add(MDC_CSS.TOP_APP_BAR__TITLE)
      ..text = appData.userField;
    endSection.append(accountField);

    List<AnchorElement> iconsElements = appData.icons.map((String iconStr) =>
       new AnchorElement(href: '#')
         ..classes.addAll([MDConsts.MATERIAL_ICONS, MDC_CSS.TOP_APP_BAR__ACTION_ITEM])
         ..text = iconStr
    ).toList();
    iconsElements.forEach((AnchorElement e){ endSection.append(e); });

    topRow.append(startSection);
    topRow.append(endSection);

    element.append(topRow);
  }

}
