"
I am the window that shows a lesson:
- the objects in it with their attributes and methods
- the objet graph
- the tests
- the workspaces
"
Class {
	#name : #OBLessonWindow,
	#superclass : #Object,
	#instVars : [
		'objectBrowser',
		'methodEditor',
		'methodEditorButton',
		'workspaceButton',
		'garbageCollectionButton',
		'objectBrowserTree',
		'statusMorph',
		'statusTextMorph',
		'groupTab',
		'pages',
		'diagram',
		'selectedTestResultTextMorph',
		'selectedTestResultBoxMorph'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #showing }
OBLessonWindow class >> show: anObjectBrowser [
	^self new show: anObjectBrowser
]

{ #category : #'test-runner' }
OBLessonWindow >> addNewEditorMorphTo: panel [
	| testEditor hSepFrac testEditorModel |
	hSepFrac := 0.45.
	testEditor := (PluggableTextMorph
		on: (testEditorModel := OBTestEditorModel newOn: self objectBrowser)
		text: #selectedTestCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:)
		setNameTo: #textoTest;
		color: Color white;
		yourself.
	testEditor styler workspace: self lesson.
	testEditor styled: true.
	self objectBrowser addTestSelectionInterested: testEditor.
	testEditorModel testEditorMorph: methodEditor.

	panel
		addMorph:
			((PluggableIconListMorph
				on: (OBTestsListModel newOn: self objectBrowser)
				list: #listModel
				selected: #listIndex
				changeSelected: #listIndex:
				menu: #listMenu:shifted:
				keystroke: #listKey:from:)
				borderWidth: 0;
				enableDragNDrop: false;
				autoDeselect: true;
				getIconSelector: #iconAt:;
				yourself)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 0.4999 @ hSepFrac - 0.01)).
	panel addMorph: testEditor fullFrame: (LayoutFrame fractions: (0 @ hSepFrac corner: 1 @ 1)).
	^ panel
]

{ #category : #'test-runner' }
OBLessonWindow >> addNewRunAllTestsButtonMorphTo: panel [
	panel
		addMorph:
			(PluggableButtonMorph
				on: self objectBrowser
				getState: nil
				action: #runAllTests
				label: #runAllTestsLabel)
		fullFrame: (LayoutFrame fractions: (0.499 @ 0.1 corner: 0.99 @ 0.2))
]

{ #category : #'test-runner' }
OBLessonWindow >> addNewSelectedTestResultMorphTo: panel [
	panel
		addMorph:
			(selectedTestResultBoxMorph := PanelMorph new
				changeProportionalLayout;
				yourself)
		fullFrame: (LayoutFrame fractions: (0.499 @ 0.21 corner: 0.99 @ 0.44)).
	selectedTestResultBoxMorph
		addMorph:
			((selectedTestResultTextMorph := PluggableTextMorph on: self objectBrowser text: #selectedTestResultDescription accept: nil)
				disable;
				yourself)
		fullFrame: (LayoutFrame fractions: (0.1 @ 0.1 corner: 0.9 @ 0.9))
]

{ #category : #'test-runner' }
OBLessonWindow >> addNewStatusMorphTo: panel [
	panel
		addMorph:
			(statusMorph := PanelMorph new
				changeProportionalLayout;
				yourself)
		fullFrame: (LayoutFrame fractions: (0.499 @ 0 corner: 0.99 @ 0.09)).
	statusMorph color: Color green.
	statusMorph
		addMorph:
			(statusTextMorph := LabelMorph new
				color: Color black;
				contents: '';
				yourself)
		fullFrame: (LayoutFrame fractions: (0.1 @ 0.1 corner: 0.9 @ 0.9))
]

{ #category : #view }
OBLessonWindow >> backgroundColorFor: category [ 
	^ category = #diagram ifTrue: [Color white ] ifFalse: [Color lightGray ].
]

{ #category : #view }
OBLessonWindow >> buildMethodEditor [
	| model |
	methodEditor := (PluggableTextMorph
		on: (model := OBMethodEditorModel newOn: self objectBrowser )
		text: #selectedMethodCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoMetodo.
	methodEditor styled: true.
	methodEditor styler workspace: self lesson.
	
	self objectBrowser addObjectSelectionInterested: methodEditor.
	self objectBrowser addObjectSelectionInterested: model.
	model methodEditorMorph: methodEditor.
	
	^methodEditor
]

{ #category : #view }
OBLessonWindow >> buildMethodList [

	^ (PluggableIconListMorph
		on: (OBMethodListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:)
		borderWidth: 0;
		enableDragNDrop: false;
		autoDeselect: true;
		getIconSelector: #iconAt:;
		yourself
]

{ #category : #view }
OBLessonWindow >> buildObjectAttributeList [

	^ (PluggableIconListMorph
		on: (OBAttributeListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:)
		borderWidth: 0;
		enableDragNDrop: false;
		autoDeselect: true;
		getIconSelector: #iconAt:;
		yourself
]

{ #category : #view }
OBLessonWindow >> buildObjectBrowserTree [
	objectBrowserTree := (PluggableTreeMorphWithDoubleClick 
		on: self objectBrowser
		list: #lessonOrganization
		selected: #selectedItem
		changeSelected: #selectedItem:
		menu: #selectedItemMenu:
		keystroke: nil).
	objectBrowserTree doubleClickSelector: #openInWorld.
	^objectBrowserTree
			
]

{ #category : #view }
OBLessonWindow >> createGroupTab [
	pages at: #objects put: self createObjectEditionTab.
	pages at: #tests put: self createTestRunnerTab.
	pages at: #diagram put: self createObjectDiagramTab.
]

{ #category : #view }
OBLessonWindow >> createObjectDiagramTab [
	| hSepFrac panel scrollPane |
	scrollPane := ScrollPane new.
	diagram := self lesson objectDiagram. 
	scrollPane scroller addMorph: diagram diagramMorph.
	hSepFrac := 0.45.
	panel := PanelMorph new
		color: (Color gray);
		changeProportionalLayout;
		addMorph: (scrollPane )
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1)).
	^panel.
]

{ #category : #view }
OBLessonWindow >> createObjectEditionTab [
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := PanelMorph new
		color: (Color gray);
		changeProportionalLayout;
		addMorph: self buildObjectAttributeList 
		fullFrame: (LayoutFrame fractions: (0@0 corner: 0.4999 @ hSepFrac -0.01));
		addMorph: self buildMethodList
		fullFrame: (LayoutFrame fractions: (0.50001@ 0 corner: 1.01 @ hSepFrac -0.01));
		addMorph: self buildMethodEditor
		fullFrame: (LayoutFrame fractions: (0@hSepFrac corner: 1 @ 1)).
	methodEditor color: Color white.
	panel color: Color lightGray.
	^panel.
]

{ #category : #'test-runner' }
OBLessonWindow >> createTestRunnerTab [
	|  panel   |
	panel := PanelMorph new
		color: Color gray;
		changeProportionalLayout.
	self addNewEditorMorphTo: panel.	
	self addNewStatusMorphTo: panel.
	self addNewRunAllTestsButtonMorphTo: panel.
	self addNewSelectedTestResultMorphTo: panel.
	^ panel
]

{ #category : #view }
OBLessonWindow >> createView [
	| window |
	self createGroupTab.
	window := (SystemWindow labelled: self objectBrowser title, ' - Ozono') 
		model: self objectBrowser;
		addMorph: self buildObjectBrowserTree
			frame: (0@0 corner: 0.2@1).
	
	window onAnnouncement: MorphDeleted send: #closeWorkspaces to: self objectBrowser.
	
	pages keysAndValuesDo: [ :k :m |
			window addMorph: m frame: (0.2@0 corner: 1@1).
			m visible: k == self objectBrowser selectedPage.
			m color: (self backgroundColorFor: k).
		].
	window center: World center.
	self objectBrowser changed.
	^window.
]

{ #category : #actions }
OBLessonWindow >> expandReferences [
	(objectBrowserTree allItems at: 1) isExpanded
		ifFalse: [ 
			(objectBrowserTree allItems at: 1) toggleExpandedState.
			objectBrowserTree adjustSubmorphPositions ]
]

{ #category : #'initialize-release' }
OBLessonWindow >> initialize [
	pages := Dictionary new.
]

{ #category : #accessing }
OBLessonWindow >> lesson [
	^self objectBrowser lesson
]

{ #category : #accessing }
OBLessonWindow >> objectBrowser [
	^objectBrowser 
]

{ #category : #accessing }
OBLessonWindow >> objectBrowser: anObjectBrowser. [
	objectBrowser := anObjectBrowser.
	objectBrowser dependant: self.
]

{ #category : #view }
OBLessonWindow >> objectGraphButtonLabel [
	^'Diagrama de objetos' translated 
]

{ #category : #view }
OBLessonWindow >> refresh [
	self refreshObjectBrowserTree.
	self refreshPagesVisibility.
	self refreshDiagram.
	self refreshTestResult
]

{ #category : #view }
OBLessonWindow >> refreshDiagram [
	self objectBrowser selectedPage = #diagram
		ifTrue: [ diagram update ]
]

{ #category : #view }
OBLessonWindow >> refreshObjectBrowserTree [
	objectBrowserTree
		ifNotNil: [ 
			objectBrowserTree list: self objectBrowser lessonOrganization.
			objectBrowserTree selection: self objectBrowser selectedItem ]
]

{ #category : #view }
OBLessonWindow >> refreshPagesVisibility [
	pages keysAndValuesDo: [ :k :v | v visible: k == self objectBrowser selectedPage ]
]

{ #category : #view }
OBLessonWindow >> refreshTestResult [
	| selectedTest |
	selectedTest := self objectBrowser selectedTest.
	selectedTest isNotNil & selectedTestResultTextMorph isNotNil
		ifTrue: [ 
			selectedTestResultTextMorph update: selectedTestResultTextMorph getTextSelector.
			selectedTestResultBoxMorph color: selectedTest resultColor ]
]

{ #category : #accessing }
OBLessonWindow >> selectedItemMenu: aMenu [
	self selectedItem menu: aMenu.
]

{ #category : #accessing }
OBLessonWindow >> setGroupTabIndex: anIndex [
	self objectBrowser selectedTabIndex: anIndex.
	groupTab selectedPageIndex: anIndex 
]

{ #category : #accessing }
OBLessonWindow >> setTestsResults: result [
	statusTextMorph contents: result printString.
	statusMorph color: result color
]

{ #category : #view }
OBLessonWindow >> show: anObjectBrowser [ 
	self objectBrowser: anObjectBrowser.
	^self createView openInWorld.
]

{ #category : #view }
OBLessonWindow >> workspaceButtonLabel [
	^'Abrir Workspace' translated 
]
