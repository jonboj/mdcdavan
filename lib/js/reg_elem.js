
function buildSlider(element, listenChange) {
  console.log('reg_elem.buildSlider');
  var e = new mdc.slider.MDCSlider(element);
  e.listen('MDCSlider:change', () => listenChange(e.value));
  return element;
}

function MdcDialogJS(element) {
  console.log('reg_elem.MdcDialogJS');
  return new mdc.dialog.MDCDialog(element);
}

function MdcSnackbarJS(element) {
  console.log('reg_elem.MdcSnackbarJS');
  var e = new mdc.snackbar.MDCSnackbar(element);
  e.showText = (text) => {
    const dataObj = {
      message: text
    }
    e.show(dataObj);
  }
  return e;
}

function MdcDrawerJS(element) {
  console.log('reg_elem.MdcDrawerJS');
  return new mdc.drawer.MDCDrawer(element);
}

function MdcListJS(element) {
  console.log('reg_elem.MdcListJS');
  return new mdc.list.MDCList(element);
}

function MdcTextFieldJS(element) {
  console.log('reg_elem.MdcTextFieldJS');
  return new mdc.textField.MDCTextField(element);
}
