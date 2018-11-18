
import 'dart:html';

import 'package:async/async.dart';
import 'package:mdcdavan/src/mdcweb/reg_elem.dart' as jsreg;

import '../mda_base/mda_base_elem.dart';
import '../mda_base/mdc_elem_spec.dart';

import 'mdc_css_classes.dart';
import 'html_const.dart';
import 'mdc_list_item.dart';

class MdcList extends MdaNodeElem implements MdcJsComp, MdaStreamElem<int> {
  static const String STREAM_ID = 'MDC_LIST';

  static const MdcElemSpec _ELEM_SPEC = const MdcElemSpec(HtmlConsts.NAV, MDC_CSS.LIST);
  jsreg.MdcListJS _mdcListJS;
  List<MdcListItem> _contentItems;

  MdcList(List<MdcListItem> this._contentItems)
      : super(_ELEM_SPEC.build(), _contentItems);

  @override
  void mdcJsInitialSyncWithDOM() {
    _mdcListJS = new jsreg.MdcListJS(element);
  }

  @override
  StreamRef<int> getStreamRef() =>
      new StreamRef(STREAM_ID, _getSelectStream());

  Stream<int> _getSelectStream() {
    StreamGroup<int> streamGroupInt = new StreamGroup<int>();

    for(int i = 0; i < _contentItems.length; ++i) {
      streamGroupInt.add(_mapStream(_contentItems[i], i));
    }
    return streamGroupInt.stream;
  }

  Stream<int> _mapStream(MdcListItem item, int i) =>
      item.element.onClick.map((MouseEvent e) => i);

}
