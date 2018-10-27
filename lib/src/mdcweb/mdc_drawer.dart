import 'dart:html';
import 'dart:async';

import 'package:mdcdavan/src/mdcweb/reg_elem.dart' as jsreg;

import '../mda_base/mda_base_elem.dart';
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';
import 'mdc_list.dart';
import 'mdc_list_item.dart';

class MdcDrawerDataDemo extends MdcDrawerData {
  const MdcDrawerDataDemo()
      : super('Drawer Title', 'Drawer SubTitle', const [['Text 1', 'mail'], ['Text 2', 'account_circle']]);
}

class MdcDrawerData {
  final String drawerTitle;
  final String drawerSubTitle;
  final List<List<String>> menuListData;

  const MdcDrawerData(this.drawerTitle, this.drawerSubTitle, this.menuListData);
}

class MdcDrawer extends MdaNodeElem implements MdcJsComp {

  static const MdcElemSpec _ELEM_SPEC = const MdcElemSpec(HtmlConsts.ASIDE, MDC_CSS.DRAWER);

  jsreg.MdcDrawerJS _mdcDrawerJS;
  DivElement _scrim;

  MdcDrawer(MdcDrawerData drawerData)
      : super(_buildMain(drawerData), [_buildMenuList(drawerData)]);

  set open(bool state) {
    _mdcDrawerJS.open = state;
  }

  @override
  void extraDomCleanup() {
    print('MdcDrawer.removeFromDom');
    _scrim.remove();
  }

  @override
  void mdcJsInitialSyncWithDOM() {
    _addDrawerScrim();
    _mdcDrawerJS = new jsreg.MdcDrawerJS(element);
  }

  static Element _buildMain(MdcDrawerData drawerData) {
    Element e = _ELEM_SPEC.build();
    e.classes.add(MDC_CSS.DRAWER__MODAL);

    DivElement header = new DivElement()
      ..classes.add(MDC_CSS.DRAWER__HEADER)
      ..append(document.createElement('h3')
        ..classes.add(MDC_CSS.DRAWER__TITLE)..text = drawerData.drawerTitle)

      ..append(document.createElement('h6')
        ..classes.add(MDC_CSS.DRAWER__SUBTITLE)..text = drawerData.drawerSubTitle);

    e.append(
        new DivElement()
          ..classes.add(MDC_CSS.DRAWER__HEADER)
          ..append(header)
    );

    return e;
  }

  static MdcList _buildMenuList(MdcDrawerData drawerData) {
    final List<MdcListItem> menuListItems =
      drawerData.menuListData.map((List<String> fields) => new MdcListItem(fields[0], fields[1])).toList();

    return new MdcList(menuListItems)..element.classes.add(MDC_CSS.DRAWER__CONTENT);
  }

  void _addDrawerScrim() {
    if (_scrim != null) {
      _scrim.remove();
    }
    _scrim = new DivElement()..classes.add(MDC_CSS.DRAWER_SCRIM);
    element.parent.append(_scrim);
  }
}
