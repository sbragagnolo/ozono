Class {
	#name : #ObjectBrowserWindow,
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
		'diagram'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> show: anObjectBrowser [
	^self new show: anObjectBrowser
]

{ #category : #view }
ObjectBrowserWindow >> backgroundColorFor: category [ 
	^ category = #diagram ifTrue: [Color white ] ifFalse: [Color lightGray ].
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodEditor [
	| model |
	methodEditor := (PluggableTextMorph
		on: (model := MethodEditorModel newOn: self objectBrowser )
		text: #selectedMethodCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoMetodo.
	methodEditor styled: true.
	self objectBrowser addObjectSelectionInterested: methodEditor.
	self objectBrowser addObjectSelectionInterested: model.
	model methodEditorMorph: methodEditor.
	
	^methodEditor
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodList [
	^ ObjectBrowserPluggableListMorph on: (MethodListModel newOn: self objectBrowser)
]

{ #category : #view }
ObjectBrowserWindow >> buildObjectAttributeList [
	^ ObjectBrowserPluggableListMorph on: (ObjectAttributeListModel newOn: self objectBrowser).

]

{ #category : #view }
ObjectBrowserWindow >> buildObjectBrowserTree [
	^objectBrowserTree := (PluggableTreeMorph 
		on: self objectBrowser
		list: #lessonOrganization
		selected: #selectedItem
		changeSelected: #selectedItem:
		menu: #selectedItemMenu:)
			
]

{ #category : #view }
ObjectBrowserWindow >> createGroupTab [
	pages at: #objects put: self createObjectEditionTab.
	pages at: #tests put: self createTestRunnerTab.
	pages at: #diagram put: self createObjectDiagramTab.
]

{ #category : #view }
ObjectBrowserWindow >> createObjectDiagramTab [
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
ObjectBrowserWindow >> createObjectEditionTab [
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
ObjectBrowserWindow >> createTestRunnerTab [
	| hSepFrac panel testRunner aBuilder window testEditor testEditorModel |
	hSepFrac := 0.45.

	testEditor := (PluggableTextMorph 
		on: (testEditorModel := TestEditorModel newOn: self objectBrowser )
		text: #selectedTestCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoTest;
		color: Color white;
		yourself.
	testEditor styled: true.
	self objectBrowser addTestSelectionInterested: testEditor.
	testEditorModel testEditorMorph: methodEditor.

	panel := PanelMorph new
		color: (Color gray);
		changeProportionalLayout.
		
	panel
		addMorph: (ObjectBrowserPluggableListMorph on: (ObjectTestsListModel newOn: self objectBrowser))
		fullFrame: (LayoutFrame fractions: (0@0 corner: 0.4999 @ hSepFrac -0.01)).
	panel
		addMorph: testEditor
		fullFrame: (LayoutFrame fractions: (0@hSepFrac corner: 1 @ 1)).
	
	panel
		addMorph: (statusMorph := (PanelMorph new changeProportionalLayout; yourself))	
		fullFrame: (LayoutFrame fractions: (0.499@0 corner: 0.99@0.09)).
	
	statusMorph color: Color green.
	statusMorph
		addMorph: (statusTextMorph := (LabelMorph new color: Color black; contents: ''; yourself))
		fullFrame: (LayoutFrame fractions: (0.1@0.1 corner: 0.9@0.9)).
	
	panel
		addMorph: (PluggableButtonMorph on: self objectBrowser getState: nil action: #runAllTests label: #runAllTestsLabel)
		fullFrame: (LayoutFrame fractions: (0.499@0.1 corner: 0.99@0.2)).
		
	^panel.
]

{ #category : #view }
ObjectBrowserWindow >> createView [
	| hSepFrac window |
	hSepFrac := 0.45.
	self createGroupTab.
	window := (ObjectBrowserSystemWindow labelled: self objectBrowser title, ' - Object Browser') 
		model: self objectBrowser;
		addMorph: self buildObjectBrowserTree
			frame: (0@0 corner: 0.2@1).
	pages keysAndValuesDo: [ :k :m |
			window addMorph: m frame: (0.2@0 corner: 1@1).
			m visible: k == self objectBrowser selectedPage.
			m color: (self backgroundColorFor: k).
		].
	window center: World center.
	self objectBrowser changed.
	^window.
]

{ #category : #'initialize-release' }
ObjectBrowserWindow >> initialize [
	pages := Dictionary new.
]

{ #category : #accessing }
ObjectBrowserWindow >> lesson [
	^self objectBrowser lesson
]

{ #category : #accessing }
ObjectBrowserWindow >> objectBrowser [
	^objectBrowser 
]

{ #category : #accessing }
ObjectBrowserWindow >> objectBrowser: anObjectBrowser. [
	objectBrowser := anObjectBrowser.
	objectBrowser dependant: self.
]

{ #category : #view }
ObjectBrowserWindow >> objectGraphButtonLabel [
	^'Diagrama de objetos' translated 
]

{ #category : #view }
ObjectBrowserWindow >> refresh [
	objectBrowserTree ifNotNil: [ objectBrowserTree list: self objectBrowser lessonOrganization ].
	objectBrowserTree ifNotNil: [objectBrowserTree selection: self objectBrowser selectedItem].
	
	pages keysAndValuesDo: [:k :v |
			v visible: (k == self objectBrowser selectedPage)
		].
	self objectBrowser selectedPage = #diagram ifTrue: [diagram update]
]

{ #category : #accessing }
ObjectBrowserWindow >> selectedItemMenu: aMenu [
	self selectedItem menu: aMenu.
]

{ #category : #accessing }
ObjectBrowserWindow >> setGroupTabIndex: anIndex [
	self objectBrowser selectedTabIndex: anIndex.
	groupTab selectedPageIndex: anIndex 
]

{ #category : #accessing }
ObjectBrowserWindow >> setTestsResults: result [
	statusTextMorph contents: result printString.
	statusMorph color: (result color).
]

{ #category : #view }
ObjectBrowserWindow >> show: anObjectBrowser [ 
	self objectBrowser: anObjectBrowser.
	^self createView openInWorld.
]

{ #category : #view }
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Abrir Workspace' translated 
]
