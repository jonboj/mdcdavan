# Mdcdavan

Dart library for writting web apps using Dart wrapping of [mdc web](https://github.com/material-components/material-components-web)
components through a `js_interop` layer. Additional a React like micro application framework, with
Streams for upward dataflow and new object instances for downward dataflow.

Current version of `mdcdavan` is a minimal test of concept. Feedback as issues and feature requests are welcome,
but current scope is only test of design concept, hence not intended for PRs.

## Demo - Tutorial

Project for small demo/tutorial app [mdairtrip project](https://github.com/jonboj/mdairtrip)
, hosted build [mdairtrip build](https://jonboj.net/mdairtrip).


## Design

Mdcdavan consists of wrapped vanilla mdc web components e.g. [MDCList](https://github.com/material-components/material-components-web/tree/master/packages/mdc-list).
Combined with a micro application framework implemented with Dart.

### Mdc web wrapping

Dart wrapping is implemented with aggregation of js vanilla MDC web objects using [package:js](https://pub.dartlang.org/packages/js).

For instantiation Mdc web components can be divided in two categories. With or without
[initialSyncWithDOM](https://github.com/material-components/material-components-web/tree/master/packages/mdc-base#methods).
Identified by having an `index.js` implementation. `initialSyncWithDOM` is invoked at
the constructor after appending the element to the DOM.

Mdc components with `initialSyncWithDOM` are wrapped using three layers, using MdcDrawer as an example:

-- dart --

`MdcDrawer`, which aggregates an instance of `MdcDrawerJS`.

-- dart-js --

`MdcDrawerJS`, instantiates a js object `mdc.drawer.MDCDrawer`

-- js --

`mdc.drawer.MDCDrawer`

Dart implementation for this type of components implements interface `MdcJsComp`, where the
method `mdcJsInitialSyncWithDOM()` setup the aggregate js object e.g. `MdcDrawerJS`. Invocation of
`mdcJsInitialSyncWithDOM()` is handled by the framework.

Mdc web components without `index.js` in the implementation don't need an
aggregated js object. e.g. `MdcIconButton` at js [mdc-icon-button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button).


#### Mdc web CSS classes

Mdc web components has related a set of css classes e.g. `mdc-drawer` and `mdc-drawer__content`.
These parsed from `material-components-web.min.css` with a console Dart program ( `mdc_cssparse.dart` )
as constants into Dart class `MDC_CSS`. Hence `MDC_CSS` acts as a checked reference for mdc web css classes definitions.
Current version of `MDC_CSS` is based on mdc web version `0.40.0`.

#### Mdc web import

Mdc web library import could be done through e.g. `index.html` below shown for version `0.40.0`

`<link rel="stylesheet" href="https://unpkg.com/material-components-web@0.40.0/dist/material-components-web.min.css">`
`<script src="https://unpkg.com/material-components-web@0.40.0/dist/material-components-web.min.js"></script>`


### App framework

**mdcdavan** contains a small concept framework for writting web apps based on Dart wrapped mdc components.
An app is based on a tree structured collection of Dart mdc components, with components inserted as childs
to `MdaNodeElem` objects.

The root of a `MdaNodeElem` tree structure is initial appended and later updated through a `MdaDomEntryHandle`.

Dataflow upward from components is handled with `Stream`s accessible at `MdaDomEntryHandle`. Downwards the
tree dataflow is done with new instances of `MdaNodeElem` root nodes, where the `MdaDomEntryHandle`
handles DOM update with new elements.

### Limitations

A test/demo of concept.

Only an illustrative subset of the mdc web components are wrapped in current version.

Hasn't been considered if design gives optimal DOM render performance.

### Contributions

A test/demo of concept, not mature for Pull Requests. Bugs and feature
requests are welcome and will be considered. Other feedback is welcome.
