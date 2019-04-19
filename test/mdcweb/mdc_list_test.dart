@TestOn("browser")

import "package:test/test.dart";

import "package:mdcdavan/src/mdcweb/mdc_list.dart";
import "package:mdcdavan/src/mdcweb/mdc_list_item.dart";

void main() {
  test("MdcList empty list", () {

    MdcList mdcList = new MdcList([]);
    expect(mdcList.element.outerHtml, equals('<nav class="mdc-list"></nav>'));
  });

  test("MdcList two elements", () {

    MdcListItem item1 = new MdcListItem('Send 1', 'send');
    MdcList mdcList = new MdcList([item1, new MdcListItem('Mail 2', 'mail')]);
    expect( mdcList.element.outerHtml, equals('<nav class="mdc-list"><a class="mdc-list-item" tabindex="0"><i class="material-icons mdc-list-item__graphic" aria-hidden="true">send</i><span class="mdc-list-item__text">Send 1</span></a><a class="mdc-list-item" tabindex="0"><i class="material-icons mdc-list-item__graphic" aria-hidden="true">mail</i><span class="mdc-list-item__text">Mail 2</span></a></nav>'));

    expect( mdcList.selectStream(), emitsInOrder([0]));
    item1.element.click();
  });

}
