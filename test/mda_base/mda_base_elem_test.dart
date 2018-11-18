@TestOn("browser")

import 'dart:html';

import "package:test/test.dart";

import "package:mdcdavan/src/mda_base/mda_base_elem.dart";


class TestMdaNodeElem extends MdaNodeElem {
  TestMdaNodeElem(Element e, List<MdaBaseElem> childs) : super(e, childs);
}

class TestMdaBaseElem extends MdaBaseElem {
  TestMdaBaseElem(Element e) {
    element = e;
  }
}

class TestMdcJsComp extends TestMdaBaseElem implements MdcJsComp {
  bool initJsSync = false;
  TestMdcJsComp(Element e) : super(e);

  void mdcJsInitialSyncWithDOM() {
    initJsSync = true;
  }
}

class TestStreamElem extends TestMdaBaseElem implements MdaStreamElem<int> {
  static const String STREAM_ID = 'TestStreamElem';
  int clickCount = 0;
  TestStreamElem(Element e) : super(e);

  StreamRef<int> getStreamRef() =>
      new StreamRef<int>(STREAM_ID, element.onClick.map((MouseEvent e) => ++clickCount));
}

void main() {
  test("MdaNodeElem no childs", () {

    TestMdaNodeElem mdcEmpty = new TestMdaNodeElem(new DivElement()..text = 'Test - MdaNodeElem', []);
    expect(mdcEmpty.element.outerHtml, equals('<div>Test - MdaNodeElem</div>'));
  });

  test("MdaNodeElem two childs, childs MdaNodeElems", () {

    TestMdaNodeElem child1 = new TestMdaNodeElem(new DivElement()..text = 'Child1', []);
    TestMdaNodeElem child2 = new TestMdaNodeElem(new DivElement()..text = 'Child2', []);
    TestMdaNodeElem mdcRoot = new TestMdaNodeElem(new DivElement()..text = 'Test - MdaNodeElem', [child1, child2]);
    expect(mdcRoot.element.outerHtml, equals('<div>Test - MdaNodeElem<div>Child1</div><div>Child2</div></div>'));
  });

  test("MdaNodeElem two childs, childs MdaBaseElems", () {

    TestMdaBaseElem child1 = new TestMdaBaseElem(new DivElement()..text = 'Child1');
    TestMdaBaseElem child2 = new TestMdaBaseElem(new DivElement()..text = 'Child2');
    TestMdaNodeElem mdcRoot = new TestMdaNodeElem(new DivElement()..text = 'Test - MdaNodeElem', [child1, child2]);
    expect(mdcRoot.element.outerHtml, equals('<div>Test - MdaNodeElem<div>Child1</div><div>Child2</div></div>'));
  });

  test("MdaNodeElem two childs, childs MdaBaseElems, one with MdcJsComp", () {

    TestMdaBaseElem child1 = new TestMdaBaseElem(new DivElement()..text = 'Child1');
    TestMdcJsComp child2 = new TestMdcJsComp(new DivElement()..text = 'Child2');
    TestMdaNodeElem mdcRoot = new TestMdaNodeElem(new DivElement()..text = 'Test - MdaNodeElem', [child1, child2]);
    Element e = new DivElement();

    expect(child2.initJsSync, false);
    MdaDomEntryHandle<TestMdaNodeElem> testEntry = MdaDomEntryHandle<TestMdaNodeElem>.entry(e, mdcRoot);
    expect(child2.initJsSync, true);

    TestMdaBaseElem child3 = new TestMdaBaseElem(new DivElement()..text = 'Child3');
    TestMdcJsComp child4 = new TestMdcJsComp(new DivElement()..text = 'Child4');
    TestMdaNodeElem mdcReplace = new TestMdaNodeElem(new DivElement()..text = 'Test - Replace MdaNodeElem', [child3, child4]);

    expect(child4.initJsSync, false);
    testEntry = testEntry.replace<TestMdaNodeElem>(mdcReplace);
    expect(child4.initJsSync, true);

    expect(e.outerHtml, equals('<div><div><div>Test - Replace MdaNodeElem<div>Child3</div><div>Child4</div></div></div></div>'));
  });

  test("MdaNodeElem two childs, childs MdaBaseElems, one with MdaStreamElem", () {

    TestMdaBaseElem child1 = new TestMdaBaseElem(new DivElement()..text = 'Child1');
    TestStreamElem child2 = new TestStreamElem(new DivElement()..text = 'Child2');
    TestMdaNodeElem mdcRoot = new TestMdaNodeElem(new DivElement()..text = 'Test - MdaNodeElem', [child1, child2]);
    Element e = new DivElement();

    MdaDomEntryHandle<TestMdaNodeElem> testEntry = MdaDomEntryHandle<TestMdaNodeElem>.entry(e, mdcRoot);
    Stream<int> stream = testEntry.getStreamMap()[TestStreamElem.STREAM_ID];
    expect(stream, emitsInOrder([1, 2]));
    child2.element.click();
    child2.element.click();
  });

}
