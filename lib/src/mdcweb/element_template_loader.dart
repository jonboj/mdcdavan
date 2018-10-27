
import 'dart:html';

class ElementTemplateLoader {

  static final _nodeValidator =
    new NodeValidatorBuilder()
      ..allowHtml5()
      ..allowElement('div', attributes: ['*'])
      ..allowElement('i', attributes: ['*'])
      ..allowElement('ul', attributes: ['*'])
      ..allowSvg();

  static DocumentFragment tempElementStr(final String templateContent) {
    TemplateElement t = new TemplateElement();
    t.setInnerHtml(templateContent, validator: _nodeValidator);
    return t.content.clone(true);
  }

}