
import 'dart:html';

abstract class MdcJsComp {
  void mdcJsInitialSyncWithDOM();
}

//Basic common
abstract class MdaBaseElem {
  Element _e;
  Element get element => _e;
  set element(Element e) { _e = e; }
}

//Node in tree.
abstract class MdaNodeElem extends MdaBaseElem {
  List<MdaBaseElem> _childs;

  MdaNodeElem(final Element e) {
    element = e;
  }

  List<MdaBaseElem> get childs => _childs;

  void buildWithChilds(final List<MdaBaseElem> childs) {
    _setChilds(childs);
    _buildDomNodes();
  }

  //When more cleanup needed override.
  void extraDomCleanup() {
  }

  void _setChilds(final List<MdaBaseElem> childs) {
    _childs = childs;
  }

  void _buildDomNodes() {
    _childs.forEach((MdaBaseElem mdaE){ element.append(mdaE.element); });
  }

  List<MdcJsComp> _getDeepMdcJsCompChilds() {
    List<MdcJsComp> lCompElem = _childs.whereType<MdcJsComp>().toList();

    List<List<MdcJsComp>> lCompElemSub = _childs.whereType<MdaNodeElem>()
        .map((MdaNodeElem c) => c._getDeepMdcJsCompChilds()).toList();

    if (lCompElemSub.isNotEmpty) {
      lCompElem.addAll(lCompElemSub.reduce((ll, l) => ll..addAll(l)));
    }

    return lCompElem;
  }
}

abstract class MdaNodeElemStatic extends MdaNodeElem {
  MdaNodeElemStatic(final Element e, final List<MdaBaseElem> childs)
      : super(e){
    buildWithChilds(childs);
  }
}

//Root element for insert/replace at dom.
class MdaDomEntryHandle<T extends MdaBaseElem> extends MdaNodeElem {

  T _node;
  List<MdcJsComp> _syncDomElements;
  MdaDomEntryHandle(final Element e, final T this._node)
    : super(e) {

    buildWithChilds([_node]);
    _syncDomElements = _getDeepMdcJsCompChilds();
  }

  factory MdaDomEntryHandle.entry(Element parent, T mdaElem) {
    Element e = new DivElement();
    MdaDomEntryHandle<T> entryElem = new MdaDomEntryHandle<T>(e, mdaElem);
    parent.append(e);
    entryElem._syncDomElements.forEach((MdcJsComp c){ c.mdcJsInitialSyncWithDOM(); });
    return entryElem;
  }

  MdaDomEntryHandle<U> replace<U extends MdaBaseElem>(final MdaBaseElem mdaElem) {
    extraDomCleanup();
    Element e = new DivElement();
    element.replaceWith(e);
    MdaDomEntryHandle<U> entryElem = new MdaDomEntryHandle<U>(e, mdaElem);
    entryElem._syncDomElements.forEach((MdcJsComp c){ c.mdcJsInitialSyncWithDOM(); });
    return entryElem;
  }

  T get node => _node;
}