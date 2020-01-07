
import 'dart:html';

abstract class MdcJsComp {
  void mdcJsInitialSyncWithDOM();
}

//Basic common
abstract class MdaBaseElem {
  Element _e;
  Element get element => _e;
  set element(Element e) { _e = e; }

  //To handle elements with mdcJsInitialSyncWithDOM()
  void appendElem(Element parent) {
    parent.append(element);
    if (this is MdcJsComp) {
      (this as MdcJsComp).mdcJsInitialSyncWithDOM();
    }
  }

  //To handle elements with mdcJsInitialSyncWithDOM()
  void replaceElem(MdaBaseElem old) {
    old.element.replaceWith(element);
    if (this is MdcJsComp) {
      (this as MdcJsComp).mdcJsInitialSyncWithDOM();
    }
  }

}

//Node in tree.
abstract class MdaNodeElem extends MdaBaseElem {
  List<MdaBaseElem> _childs;

  MdaNodeElem(final Element e) {
    element = e;
  }

  void buildWithChilds(final List<MdaBaseElem> childs) {
    _childs = childs;
    _childs.forEach((MdaBaseElem mdaE){ mdaE.appendElem(element); });
  }

}

//Childnodes as argument in contructor.
abstract class MdaNodeElemStatic extends MdaNodeElem {
  MdaNodeElemStatic(final Element e, final List<MdaBaseElem> childs)
      : super(e){
    buildWithChilds(childs);
  }
}

//Root element for insert/replace at dom.
class MdaDomEntryHandle<T extends MdaBaseElem> extends MdaNodeElem {

  T _node;
  MdaDomEntryHandle(final Element e, final T this._node)
    : super(e) {

    buildWithChilds([_node]);
  }

  factory MdaDomEntryHandle.entry(Element parent, T mdaElem) {
    MdaDomEntryHandle<T> entryElem = new MdaDomEntryHandle<T>(new DivElement(), mdaElem);
    entryElem.appendElem(parent);
    return entryElem;
  }

  MdaDomEntryHandle<U> replace<U extends MdaBaseElem>(final MdaBaseElem mdaElem) {
    MdaDomEntryHandle<U> entryElem = new MdaDomEntryHandle<U>(new DivElement(), mdaElem);
    entryElem.replaceElem(_node);
    return entryElem;
  }

  T get node => _node;
}