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
		'diagramWhiteboard'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> show: anObjectBrowser [
	^self new show: anObjectBrowser
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodEditor [
	| model |
	methodEditor := (PluggableShoutMorph
		on: (model := MethodEditorModel newOn: self objectBrowser )
		text: #selectedMethodCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoMetodo.
	self objectBrowser addObjectSelectionInterested: methodEditor.
	model methodEditorMorph: methodEditor.
	
	^methodEditor
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodList [
	^ OBPluggableListMorph new
		on: (MethodListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #view }
ObjectBrowserWindow >> buildObjectAttributeList [
	^ (PluggableListMorph 
		on: (ObjectAttributeListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:)
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself

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
	^TabGroupMorph new
		addPage: self createObjectEditionTab label: 'Objetos';
		addPage: self createTestRunnerTab label: 'Tests';
		addPage: self createObjectDiagramTab label: 'Diagrama';
		selectedPageIndex: 1;
		yourself
]

{ #category : #view }
ObjectBrowserWindow >> createObjectDiagramTab [
	| hSepFrac panel |
	diagramWhiteboard := DiagramWhiteboard new model: self lesson objectDiagram.
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new);
		addMorph: (diagramWhiteboard).
	^panel.
]

{ #category : #view }
ObjectBrowserWindow >> createObjectEditionTab [
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new);
		addMorph: self buildObjectAttributeList 
			frame: (0@0 corner: 0.4999 @ hSepFrac -0.01);
		addMorph: self buildMethodList
			frame: (0.50001@ 0 corner: 1 @ hSepFrac -0.01);
		addMorph: self buildMethodEditor
			frame: (0@hSepFrac corner: 1 @ 1).
	methodEditor color: Color white.
	^panel.
]

{ #category : #view }
ObjectBrowserWindow >> createTestRunnerTab [
	| hSepFrac panel testRunner aBuilder window testEditor testEditorModel |
	hSepFrac := 0.45.

	testEditor := (PluggableShoutMorph
		on: (testEditorModel := TestEditorModel newOn: self objectBrowser )
		text: #selectedTestCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoTest;
		color: Color white;
		yourself.
	self objectBrowser addTestSelectionInterested: testEditor.
	testEditorModel testEditorMorph: methodEditor.

	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new).
	panel addMorph: (ObjectBrowserPluggableListMorph on: (ObjectTestsListModel newOn: self objectBrowser))
		frame: (0@0 corner: 0.499@0.499).
	panel addMorph: testEditor
		frame: (0@0.499 corner: 1@1).
	panel addMorph: (statusMorph := (NewTextMorph  new color: Color red; readOnly: true; yourself))	
		frame: (0.499@0 corner: 1@0.09).
	panel addMorph: (PluggableButtonMorph on: self objectBrowser getState: nil action: #runAllTests label: #runAllTestsLabel)
		frame: (0.499@0.1 corner: 1@0.2).
	^panel.
]

{ #category : #view }
ObjectBrowserWindow >> createView [
	| hSepFrac window |
	hSepFrac := 0.45.
	window := (SystemWindow labelled: self objectBrowser title, ' - Loop Browser') 
		model: self objectBrowser;
		addMorph: self buildObjectBrowserTree
			frame: (0@0 corner: 0.2@1);
		addMorph: self createGroupTab
			frame: (0.2@0 corner: 1@1);
		center: World center.
	
	^window.
]

{ #category : #'user interface' }
ObjectBrowserWindow >> lesson [
	^self objectBrowser lesson
]

{ #category : #view }
ObjectBrowserWindow >> objectBrowser [
	^objectBrowser 
]

{ #category : #view }
ObjectBrowserWindow >> objectBrowser: anObjectBrowser. [
	objectBrowser := anObjectBrowser.
	objectBrowser dependant: self.
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> objectGraphButtonLabel [
	^'Diagrama de objetos'
]

{ #category : #view }
ObjectBrowserWindow >> refresh [
	objectBrowserTree list: self objectBrowser lessonOrganization.
	objectBrowserTree selection: self objectBrowser selectedItem.
	diagramWhiteboard model: self lesson objectDiagram.
	diagramWhiteboard update.
]

{ #category : #view }
ObjectBrowserWindow >> selectedItemMenu: aMenu [
	self selectedItem menu: aMenu.
]

{ #category : #view }
ObjectBrowserWindow >> setTestsResults: result [
	statusMorph text: result printString.
	statusMorph color: (self statusColorFor: result).
]

{ #category : #view }
ObjectBrowserWindow >> show: anObjectBrowser [ 
	self objectBrowser: anObjectBrowser.
	^self createView openInWorld.
]

{ #category : #view }
ObjectBrowserWindow >> showWorkspace [
	(LOOPWorkspace new 
		openLabel: objectBrowser title, ' - Workspace';
		lesson: objectBrowser lesson; 
		containingWindow) center: World center.
]

{ #category : #view }
ObjectBrowserWindow >> statusColorFor: result [
	result hasErrors 
		ifTrue: [ ^ Color red ].
	result hasFailures 
		ifTrue: [ ^ Color yellow ].
	^Color green
]

{ #category : #view }
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Abrir Workspace'
]
