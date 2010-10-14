Class {
	#name : #ObjectBrowserWindow,
	#superclass : #Object,
	#instVars : [
		'objectBrowser',
		'methodEditor',
		'methodEditorButton',
		'workspaceButton',
		'garbageCollectionButton',
		'objectBrowserTree'
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
	^ PluggableListMorph new
		on: (ObjectAttributeListModel newOn: self objectBrowser)
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
		selectedPageIndex: 1;
		yourself
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
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new)";
		addMorph: self buildObjectAttributeList 
			frame: (0@0 corner: 0.4999 @ hSepFrac -0.01);
		addMorph: self buildMethodList
			frame: (0.50001@ 0 corner: 1 @ hSepFrac -0.01);
		addMorph: self buildMethodEditor
			frame: (0@hSepFrac corner: 1 @ 1)".
	"methodEditor color: Color white."
	^panel.
]

{ #category : #view }
ObjectBrowserWindow >> createView [
	| hSepFrac window |
	hSepFrac := 0.45.
	window := (SystemWindow labelled: self objectBrowser title, ' - Loop Browser') 
		model: self objectBrowser;
		addMorph: self buildObjectBrowserTree
			frame: (0@0 corner: 0.33@1);
		addMorph: self createGroupTab
			frame: (0.33@0 corner: 1@1);
		center: World center.
	
	^window.
]

{ #category : #view }
ObjectBrowserWindow >> createViewOld [
	| hSepFrac window |
	hSepFrac := 0.45.
	window := (SystemWindow labelled: self objectBrowser title, ' - Loop Browser') model: self objectBrowser;
		addMorph: self buildObjectAttributeList 
		frame: (0.33 @ 0 corner: 0.66 @ hSepFrac);
		
		addMorph: self buildMethodList
		frame: (0.66 @ 0 corner: 1 @ hSepFrac);
		
		addMorph: self buildMethodEditor
		frame: (0.33@ (hSepFrac) corner: 1 @ 1);
		
		center: World center.
	
	^window.
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
	^'Object Diagram'
]

{ #category : #view }
ObjectBrowserWindow >> refresh [
	objectBrowserTree list: self objectBrowser lessonOrganization.
	objectBrowserTree selection: self objectBrowser selectedItem.
]

{ #category : #view }
ObjectBrowserWindow >> selectedItemMenu: aMenu [
	self selectedItem menu: aMenu.
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
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Open Workspace'
]
