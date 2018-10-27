
import 'dart:html';

class MdcElemSpec {
  final String elementType;
  final String cssClass;
  final List<String> extraCssClasses;
  const MdcElemSpec(this.elementType, this.cssClass, [List<String> this.extraCssClasses]);

  Element build() {
    Element e = document.createElement(elementType)
      ..classes.add(cssClass);
    if (extraCssClasses != null){
      e.classes.addAll(extraCssClasses);
    }
    return e;
  }

}
