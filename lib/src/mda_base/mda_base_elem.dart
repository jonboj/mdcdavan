
import 'dart:html';
import 'dart:async';

abstract class MdcJsComp {
  void mdcJsInitialSyncWithDOM();
}

class StreamRef<T> {
  final String id;
  final Stream<T> s;
  const StreamRef(final String this.id, final Stream<T> this.s);

  MapEntry<String, Stream<T>> mapEntry() =>
      new MapEntry<String, Stream<T>>(id, s);
}

abstract class MdaStreamElem<T> {
  StreamRef<T> getStreamRef();
}

//Basic common
abstract class MdaBaseElem {
  Element _e;
  Element get element => _e;
  set element(Element e) { _e = e; }
}

//Node in tree.
class MdaNodeElem extends MdaBaseElem {
  final List<MdaBaseElem> _childs;
  MdaNodeElem(final Element e, final List<MdaBaseElem> this._childs) {
    element = e;
    _childs.forEach((MdaBaseElem mdaE){ element.append(mdaE.element); });
  }

  List<MdaBaseElem> get childs => _childs;

  //When more cleanup needed override.
  void extraDomCleanup() {
  }

  List<MdcJsComp> _getDeepMdcJsCompChilds() {
    List<MdcJsComp> lStreamElem = _childs.whereType<MdcJsComp>().toList();

    List<List<MdcJsComp>> lStreamElemSub = _childs.whereType<MdaNodeElem>()
        .map((MdaNodeElem c) => c._getDeepMdcJsCompChilds()).toList();

    if (lStreamElemSub.isNotEmpty) {
      lStreamElem.addAll(lStreamElemSub.reduce((ll, l) => ll..addAll(l)));
    }

    return lStreamElem;
  }

  List<MdaStreamElem> _getDeepMdaStreamElemChilds() {
    List<MdaStreamElem> lStreamElem = _childs.whereType<MdaStreamElem>().toList();

    List<List<MdaStreamElem>> lStreamElemSub = _childs.whereType<MdaNodeElem>()
        .map((MdaNodeElem c) => c._getDeepMdaStreamElemChilds()).toList();

    if (lStreamElemSub.isNotEmpty) {
      lStreamElem.addAll(lStreamElemSub.reduce((ll, l) => ll..addAll(l)));
    }

    return lStreamElem;
  }
}

//Root element for insert/replace at dom.
class MdaDomEntryHandle<T extends MdaBaseElem> extends MdaNodeElem {

  T _node;
  List<MdcJsComp> _syncDomElements;
  List<MdaStreamElem> _streamElements;
  MdaDomEntryHandle(final Element e, final T this._node)
    : super(e, [_node]) {

    _syncDomElements = _getDeepMdcJsCompChilds();
    _streamElements = _getDeepMdaStreamElemChilds();
  }

  factory MdaDomEntryHandle.entry(Element parent, MdaBaseElem mdaElem) {
    Element e = new DivElement();
    MdaDomEntryHandle<T> entryElem = new MdaDomEntryHandle<T>(e, mdaElem);
    parent.append(e);
    entryElem._syncDomElements.forEach((MdcJsComp c){ c.mdcJsInitialSyncWithDOM(); });
    return entryElem;
  }

  MdaDomEntryHandle<T> replace(final MdaBaseElem mdaElem) {
    extraDomCleanup();
    Element e = new DivElement();
    element.replaceWith(e);
    MdaDomEntryHandle<T> entryElem = new MdaDomEntryHandle<T>(e, mdaElem);
    entryElem._syncDomElements.forEach((MdcJsComp c){ c.mdcJsInitialSyncWithDOM(); });
    return entryElem;
  }

  T get node => _node;

  Map<String, Stream> getStreamMap() =>
      Map.fromEntries( _streamElements.map((MdaStreamElem e) => e.getStreamRef().mapEntry()) );

}